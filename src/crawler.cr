require "logger"
require "http/client"
require "json"
require "./mongo/mongo"
require "./ext"

$logger = Logger.new(STDOUT)
$logger.level = (ENV["ENV"]? || "development") == "production" ? Logger::WARN : Logger::DEBUG

$cookies = HTTP::Cookies.new # Empty cookies

def invoke_cookies
  # Browse homepage to get S/N in cookies
  HTTP::Client.get("http://pblap.atm.ncu.edu.tw/") do |response|
    # Save S/N into cookie
    $cookies["pblapframeaction"] = response.cookies["pblapframeaction"]
  end
rescue e : Socket::Error
end

def get_weather(again = true)
  headers = HTTP::Headers{ "Referer" => "http://pblap.atm.ncu.edu.tw/" }
  $cookies.add_request_headers(headers)
  response = HTTP::Client.get("http://pblap.atm.ncu.edu.tw/indexReal_cam.asp", headers: headers)

  return if response.body =~ %r(即時觀測系統 維護中)

  if response.body =~ %r(Please Connect to PBLAP home page to get the S/N for NCU Realtime Weather!)
    # acquire new cookie
    invoke_cookies
    return again ? get_weather(false) : nil # try again!
  end

  time = %r(<font style="color:#800080">(?>(.*?)</font>))m.match(response.body).try do |md|
    Time.parse md[1].gsub(/&nbsp;|-/, "").gsub(/\s+/, " ").strip, "%Y/%m/%d %H:%M"
  end.not_nil!

  weather_info = /<td[^>]*id="realcamvalue">(?>(.*?)<\/td>)/m.match(response.body).try do |md|
    md[1].gsub(/<!--(?>.*?-->)/, "").gsub(/&nbsp;/, "").gsub(/\s+/, "").gsub(/<br>/, "\n")
  end.to_s

  weather_id, night = %r(<img src="ncuobs/(Sn?V\d+).jpg")m.match(response.body).try do |md|
    { case md[1]
    when "SV0", "SnV0"
      :drizzle
    when "SV1", "SnV1"
      :shower
    when "SV2", "SnV2"
      :fair
    when "SV3"
      :sunny
    when "SnV3" # night
      :clear
    when "SV4", "SnV4"
      :partly_cloudy
    when "SV5", "SnV5"
      :thundershower
    when "SV6", "SnV6"
      :mostly_cloudy
    when "SV7", "SnV7"
      :cloudy
    end, md[1][1] == 'n' }
  end.not_nil!

  {
    time: time,
    weather: weather_id,
    temperature:    weather_info.match(%r(溫度:([\d.]+)℃)).try     { |md| md[1].to_f },
    humidity:       weather_info.match(%r(濕度:([\d.]+)%)).try     { |md| md[1].to_f },
    wind_direction: weather_info.match(%r(風向:([\d.]+)°)).try     { |md| md[1].to_f },
    wind_speed:     weather_info.match(%r(風速:([\d.]+)m/s)).try   { |md| md[1].to_f },
    pressure:       weather_info.match(%r(氣壓:([\d.]+)hPa)).try   { |md| md[1].to_f },
    rain:           weather_info.match(%r(降雨:([\d.]+)mm/hr)).try { |md| md[1].to_f },
    day_or_night: night ? :night : :day
  }
rescue e : Socket::Error
end

macro def duration_next_time
  ((Time.now.at_beginning_of_minute + 1.minute) + 30.seconds - Time.now).ticks.remainder(Time::Span::TicksPerMinute).fdiv(Time::Span::TicksPerSecond).ceil
end

mongo_client = Mongo::Client.new("mongodb://#{ENV["MONGODB"]? || "localhost"}")
loop do
  # Wait for MongoDB starts
  begin
    mongo_client.server_status
  rescue e : BSON::BSONError
    $logger.info "Waiting for MongoDB"
    sleep 1
    next
  end
  break
end

$mongo : Mongo::Database
$mongo = mongo_client.database("ncu_weather")

loop do
  begin
    if weather = get_weather
      $mongo["weather"].insert weather
      $logger.debug weather.to_json
    else
      $logger.warn "no data."
    end
  rescue e # Capture other errors
    $logger.error "Exception: #{e.message}"
  end
  sleep duration_next_time
end


require "kemal"
require "./mongo/mongo"
require "./config"

$mongo : Mongo::Database
$mongo = Mongo::Client.new("mongodb://#{ENV["MONGODB"]? || "localhost"}").database("ncu_weather")

def get_last_weather
  # if data = $mongo["weather"].find_one({ "$query" => {} of String => String,  "$orderby" => { "time" => -1 } })
  if data = $mongo["weather"].find_one({
      "$query" => {} of String => String,
      "$orderby" => {
        "time" => -1
      }
  }, { "_id" => false })
    {
      time:           data["time"].as(Time).to_local.to_s("%m/%d %H:%M"),
      weather:        data["weather"].to_s,
      temperature:    data["temperature"].to_s.to_f,
      humidity:       data["humidity"].to_s.to_f,
      wind_direction: data["wind_direction"].to_s.to_f,
      wind_speed:     data["wind_speed"].to_s.to_f,
      pressure:       data["pressure"].to_s.to_f,
      rain:           data["rain"].to_s.to_f,
      day_or_night:   data["day_or_night"].to_s,
      error: false
    }
  else
    DUMMY_WEATHER
  end
end

def get_daily_aggregate
  results = [] of { time: String, temperature: Float64? }
  time = Time.now.to_local.at_beginning_of_hour
  8.times do
    if data = $mongo["weather"].find_one({
        "$query" => {
          "time" => { "$lte" => time }
        },
        "$orderby" => {
          "time" => -1
        }
    }, { "_id" => false, "time" => true, "temperature" => true })
      results << {
        time: time.to_s("%l %p"),
        temperature: data["temperature"].to_s.to_f
      }
    else
      results << {
        time: time.to_s("%l %p"),
        temperature: nil
      }
    end
    time -= 3.hours
  end
  results
end

get "/" do
  weather = get_last_weather
  if weather[:error]?
    weather_bg = DUMMY_BG
  else
    weather_bgs = WEATHER_BGS[weather[:weather]].select do |item|
      weather[:day_or_night] == "night" ? !item[:only_day] : !item[:only_night]
    end
    weather_bg = weather_bgs[Random.rand 0...weather_bgs.size]
  end
  daily_aggregate = get_daily_aggregate

  render "views/index.ecr"
end

get "/api" do |env|
  env.response.content_type = "application/json"
  {
    version: "1.0",
    data: get_last_weather
  }.to_json
end

Kemal.config do |cfg|
  cfg.port = (ENV["APP_PORT"]? || 3000).to_i
  cfg.env = ENV["ENV"]? || "development"
end

Kemal.run

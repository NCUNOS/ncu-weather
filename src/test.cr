require "./mongo/mongo"

$mongo : Mongo::Database
$mongo = Mongo::Client.new("mongodb://localhost").database("ncu_weather")

$mongo["weather"].find({
  "$query" => {} of String => String,
  "$orderby" => {
    "time" => -1
  }
}, { "_id" => false }) do |doc|
  puts doc
end

puts $mongo["weather"].find_one({
  "$query" => {} of String => String,
  "$orderby" => {
    "time" => -1
  }
}, { "_id" => false })

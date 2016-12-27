require 'rubygems'
require 'bundler/setup'
require 'json'
require 'yaml'

Bundler.require

Dotenv.load
URL = "http://www.apple.com/shop/retail/pickup-message?parts.0=MMEF2AM%2FA&location=37067"
TWILIO_SID = ENV["TWILIO_SID"]
TWILIO_AUTH = ENV["TWILIO_AUTH"]
TWILIO_NUMBER = ENV["TWILIO_NUMBER"]
MY_NUMBER = ENV["MY_NUMBER"]

# R513 CoolSprings Galleria
# R123 Green Hills
# R266 Bridge Street Huntsville
# R225 The Summit
STORES = ["R513", "R123", "R266", "R225"]
TWILIO = "https://api.twilio.com/2010-04-01/Accounts/#{TWILIO_SID}/Messages"
# AirPods
PART = "MMEF2AM/A"

@get_apple = Typhoeus.get(URL)

def load_status
  if File.exists?("./status") && (YAML.load(File.open("./status", "r")).is_a? Hash)
    @status = YAML.load(File.open("./status", "r"))
  else
    @status = {}
  end
end

def update_status(store, part)
  if @status[store["storeNumber"]].is_a? Hash
    @status[store["storeNumber"]][:previous] = @status[store["storeNumber"]][:current]
    @status[store["storeNumber"]][:current] = part["pickupDisplay"]
    @status[store["storeNumber"]][:change] = did_status_change?(store)
  else
    @status[store["storeNumber"]] = {
      previous: nil,
      current: part["pickupDisplay"],
      change: true
    }
  end
end

def did_status_change?(store)
  @status[store["storeNumber"]][:previous] != @status[store["storeNumber"]][:current]
end

def write_status
  File.open("./status", "w+") do |f|
    f.write(YAML.dump(@status))
  end
end

def send_sms(message)
  Typhoeus.post(
    TWILIO,
    userpwd: "#{TWILIO_SID}:#{TWILIO_AUTH}",
    body: {
      "From" => TWILIO_NUMBER,
      "To" => MY_NUMBER,
      "Body" => message
    },
    headers: { "Content-Type" => "application/x-www-form-urlencoded; charset=utf-8" }
  )
end

def check_inventory(store)
  part = store["partsAvailability"][PART]
  update_status(store, part)
  if @status[store["storeNumber"]][:change]
    send_sms("#{part["storePickupProductTitle"]} #{part["pickupDisplay"]} at #{store["storeName"]}!")
  else
    File.open("./log", "a+") do |f|
      f.write "#{DateTime.now}: #{part["storePickupProductTitle"]} status unchanged at #{store["storeName"]}\n"
    end
  end
end

def get_filtered_stores
  @get_apple_json["body"]["stores"].select { |store| STORES.include? store["storeNumber"] }
end

if @get_apple.success?
  load_status
  @get_apple_json = JSON.parse(@get_apple.response_body)
  get_filtered_stores.each { |store| check_inventory(store) }
  write_status
else
  send_sms("Airpods check failed at #{DateTime.now}")
end

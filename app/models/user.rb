# require 'open-uri'
# require 'json'

class User < ActiveRecord::Base
  has_secure_password 
  validates_uniqueness_of :name
  
  # Returns the distance and the duration between the logged in user and any other user
  def distance_duration_to other_runner
    distance_url = "https://maps.googleapis.com/maps/api/distancematrix/json?origins=#{self.location.gsub(" ","%20")}&destinations=#{other_runner.location.gsub(" ","%20")}&key=AIzaSyDOxZ6CpbCbh1jxvCsQc_BveDvyW4iiQsU"
    distance_parsed_result = JSON.parse(open(distance_url).read)
    {distance: distance_parsed_result['rows'][0]["elements"][0]["distance"]["text"], duration: distance_parsed_result['rows'][0]["elements"][0]["duration"]["text"]}
  end
  
  # Takes location using geocoder API and then finds distance using  Distance matrix API
#   def reverse_geocoder some_runner
#     distance_url = "https://maps.googleapis.com/maps/api/distancematrix/json?origins=#{self.location}&destinations=#{some_runner.location}&key=AIzaSyDOxZ6CpbCbh1jxvCsQc_BveDvyW4iiQsU"
#     distance_parsed_result = JSON.parse(open(distance_url).read)
#     {distance: distance_parsed_result['rows'][0]["elements"][0]["distance"]["text"], duration: distance_parsed_result['rows'][0]["elements"][0]["duration"]["text"]}
    
#   end
  
end

# require 'open-uri'
# require 'json'

class User < ActiveRecord::Base
  has_many :friendships
  has_many :friends, through: :friendships
  has_secure_password 
  validates_uniqueness_of :name
  
  # Returns the distance and the duration between the logged in user and any other user
  def distance_duration_to other_runner
    distance_url = "https://maps.googleapis.com/maps/api/distancematrix/json?origins=#{self.location.gsub(" ","%20")}&destinations=#{other_runner.location.gsub(" ","%20")}&key=AIzaSyDOxZ6CpbCbh1jxvCsQc_BveDvyW4iiQsU"
    distance_parsed_result = JSON.parse(open(distance_url).read)
    {distance: distance_parsed_result['rows'][0]["elements"][0]["distance"]["text"], duration: distance_parsed_result['rows'][0]["elements"][0]["duration"]["text"]}
  end

  def friends
    friendships = Friendship.where(user_id: self.id) #here the self refers to the native user id. USER OBJECT
    friend_list = Array.new
    friendships.each do |friendship|
      friend_list << User.find_by_id(friendship.friendship_id)
    end
    return friend_list.uniq
    
  end  
end

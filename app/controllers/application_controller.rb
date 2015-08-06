require 'open-uri'
require 'json'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def landing
    render 'Landing'
    
  end
  
  def app
    render 'Run_app'
    
  end
  
  def authorize
    redirect_to "/sessions/new" if current_user.nil? 
    flash[:message] = "Not authorized"
  end
  
  def search 
    
  end
  
  def result
    origin = params['origin'].gsub(" ", "")
    destination = params['destination'].gsub(" ", "")
    transport = params['transport'].gsub(" ", "")
    url = "https://maps.googleapis.com/maps/api/distancematrix/json?origins=#{origin}&destinations=#{destination}&mode=#{transport}&key=AIzaSyDOxZ6CpbCbh1jxvCsQc_BveDvyW4iiQsU"
    result = open(url).read
    parsed_result = JSON.parse(result)
    distance_in_km = parsed_result['rows'][0]["elements"][0]["distance"]["text"]
    @distance = distance_in_km
    @duration = parsed_result['rows'][0]["elements"][0]["duration"]["text"]
    
  end
  
  def runwith 
  end
  
  def reversegeocode #some_runner //if you get rid of this then you must get rid of bottom
    @users = User.all
    lat = params['longitude']
    long = params['latitude']
    url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=#{lat},#{long}&key=AIzaSyDZOV9q3K2BJfy2soUKCgGfOgehIKsHp5g"
    result = open(url).read
    parsed_result = JSON.parse(result)
    @location = parsed_result['results'][0]['formatted_address'].gsub(" ", "%20")
#      distance_url = "https://maps.googleapis.com/maps/api/distancematrix/json?origins=#{@location}&destinations=#{some_runner.location}&key=AIzaSyDOxZ6CpbCbh1jxvCsQc_BveDvyW4iiQsU"
#     distance_parsed_result = JSON.parse(open(distance_url).read)
#      {distance: distance_parsed_result['rows'][0]["elements"][0]["distance"]["text"], duration: distance_parsed_result['rows'][0]["elements"][0]["duration"]["text"]}

    
  end
  
  private
  def current_user
   @current_user||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user
  
  private  
def locations some_runner
@users = User.all
distance_url = "https://maps.googleapis.com/maps/api/distancematrix/json?origins=#{@location.gsub(" ","%20")}&destinations=#{some_runner.location.gsub(" ","%20")}"
distance_parsed_result = JSON.parse(open(distance_url).read)
{distance: distance_parsed_result['rows'][0]["elements"][0]["distance"]["text"], duration: distance_parsed_result['rows'][0]["elements"][0]["duration"]["text"]}
end
  helper_method :locations

end

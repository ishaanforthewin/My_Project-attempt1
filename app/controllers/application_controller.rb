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
  def reversegeocode
    @users = User.all
    @user = User.find_by_id(params["id"])
    lat = params['longitude']
    long = params['latitude']
    url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=#{lat},#{long}&key=AIzaSyDZOV9q3K2BJfy2soUKCgGfOgehIKsHp5g"
    result = open(url).read
    parsed_result = JSON.parse(result)
    
    @location = parsed_result['results'][0]['formatted_address'].gsub(" ", "%20")
    
    destination = "boston" #should be something like user.location of current showing user
    secondurl = "https://maps.googleapis.com/maps/api/distancematrix/json?origins=#{@location}&destinations=#{destination}&mode=driving&key=AIzaSyDOxZ6CpbCbh1jxvCsQc_BveDvyW4iiQsU"
    secondresult = open(secondurl).read
    parseds_result = JSON.parse(secondresult)
    distance_in_km = parseds_result['rows'][0]["elements"][0]["distance"]["text"]
    @distance = distance_in_km
    @duration = parseds_result['rows'][0]["elements"][0]["duration"]["text"]
    
  end
  
  private
  def current_user
   @current_user||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user
end

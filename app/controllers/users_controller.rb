class UsersController < ApplicationController
  before_filter :authorize, only: [:edit, :update, :destroy]
  def show
    @user = User.find_by_id(params["id"])
  end
  
  def new
    @user = User.new
  end
  
  def create 
    @user = User.new(params[:user].permit(:name, :email, :pace, :distance, :location, :password, :password_confirmation)) 
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url 
      flash[:message] = "You have successfully signed up."
    else
      render 'new'
    end
    
  end
  
  def edit
    @user = User.find_by(id: params[:id])
  end
  
  def index
    @users = User.all
   @users.each do |user|
    if session[:user_id]
      
      origin = current_user.location
      destination = user.location
      
    url = "https://maps.googleapis.com/maps/api/distancematrix/json?origins=#{origin}&destinations=#{destination}&key=AIzaSyDOxZ6CpbCbh1jxvCsQc_BveDvyW4iiQsU"
    result = open(url).read
    parsed_result = JSON.parse(result)
    distance_in_km = parsed_result['rows'][0]["elements"][0]["distance"]["text"]
    @distance = distance_in_km
    @duration =parsed_result['rows'][0]["elements"][0]["duration"]["text"]
    
    else
      origin = "boston"
      destination = user.location
    url = "https://maps.googleapis.com/maps/api/distancematrix/json?origins=#{origin}&destinations=#{destination}&key=AIzaSyDOxZ6CpbCbh1jxvCsQc_BveDvyW4iiQsU"
    result = open(url).read
    parsed_result = JSON.parse(result)
    distance_in_km = parsed_result['rows'][0]["elements"][0]["distance"]["text"]
    @distance = distance_in_km
    @duration =parsed_result['rows'][0]["elements"][0]["duration"]["text"]
    end
   end
    
  end
  
  def update 
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    @user.email = params[:email]
    @user.pace = params[:pace]
    @user.distance = params[:distance]
    @user.location = params[:location]
    if @user.save
      redirect_to "/users/#{@user.id}"
    else
      render 'edit'
    end
  end
  def destroy
    @user = User.find_by_id(params['id'])
    @user.destroy
    redirect_to "/users"
  end
end

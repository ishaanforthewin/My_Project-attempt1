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

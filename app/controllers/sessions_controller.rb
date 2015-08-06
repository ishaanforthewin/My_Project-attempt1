class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by_name(params[:name])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_url
    else
      flash[:message] ="Email or Password is invalid"
      render "new"
      
    end
  end
  def destroy
    session[:user_id] = nil
    redirect_to root_url
    flash[:message] ="Logged out"
  end
  
end

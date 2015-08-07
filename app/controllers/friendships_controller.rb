class FriendshipsController < ApplicationController
  
  def create
    @friendship = Friendship.new
    @friendship.user_id = current_user.id
    @friendship.friendship_id = params[:friend_id]
      
    if @friendship.save
      flash[:message] = "ADDED FRIEND!"
      redirect_to root_url
    else
      flash[:message] = "Friend not added"
      redirect_to root_url
    end
  end
#   def destroy  
    
#     redirect_to '/users'
   
#   end 
end
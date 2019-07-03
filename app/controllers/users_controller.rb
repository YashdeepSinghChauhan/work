class UsersController < ApplicationController
 
# GET /users
# GET /users.json
 respond_to :json
    def show
        @user = User.friendly.find(params[:id])
    end

    def following   
        @users = current_user.all_following
        @user_count = current_user.following_users_count
    end
   

   def index
   	search = params[:term].present? ? params[:term] : nil
   	@users = if search
   		User.where("username LIKE ? OR first_name LIKE ?", "%#{search}%", "%#{search}%")
   	else
   		User.all
   end 
   
end
end
class UsersController < ApplicationController
 before_action :authenticate_user!
    def show
        @user = User.friendly.find(params[:id])
    end

    def following   
        @users = current_user.all_following
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
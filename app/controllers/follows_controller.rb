class FollowsController < ApplicationController

  respond_to :js
  
  def create
    @user = User.friendly.find(params[:user_id])
    current_user.follow(@user)
    respond_to do |format|
    format.js {render inline: "location.reload();" }
   end
  end

  def destroy
    @user = User.friendly.find(params[:user_id])
    current_user.stop_following(@user)
    respond_to do |format|
      format.js {render inline: "location.reload();" }
  end
end

end
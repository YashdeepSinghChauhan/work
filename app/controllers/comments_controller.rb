class CommentsController < ApplicationController
  before_action :set_post
  before_action :authenticate_user!

  def create
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user
    def notify(user)
        Notification.create do |notification|
        notification.notify_type = 'mention_comments'
        notification.actor = @comment.user
        notification.user = @comment.mentioned_users
        notification.target = @comment
        notification.second_target = @post
      end
    end
    if @comment.save
      if @comment.mentioned_users.any?
        @comment.mentioned_users.each do |mentioned_user|
          notify(mentioned_user)
        end
      end
  end
 end 
  def destroy
    @comment = @post.comments.find(params[:id])
    @comment.destroy
  end
    
  private
  
  def comment_params
    params.require(:comment).permit(:body, :post_id)
  end
  
  def set_post
    @post = Post.friendly.find(params[:post_id])
  end
end

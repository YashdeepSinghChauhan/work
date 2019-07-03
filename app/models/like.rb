class Like < ApplicationRecord
    belongs_to :user
    belongs_to :post
    
     after_commit :create_notifications, on: :create
  
  private
  def create_notifications
    Notification.create do |notification|
      notification.notify_type = 'like'
      notification.actor = self.user
      notification.user = self.post.user
      notification.target = self
      notification.second_target = self.post
    end
  end 
end

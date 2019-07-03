class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :body, presence: true, allow_blank: false
  after_commit :create_notifications, on: :create, dependent: :destroy
  
   def mentions
       @mentions ||= begin
                        regex = /@([\w]+)/
                        matches = body.scan(regex).flatten
                    end
    end
    def mentioned_users
        @mentioned_users ||= User.where(username: mentions)
    end
  private
  def create_notifications
    Notification.create do |notification|
      notification.notify_type = 'comment'
      notification.actor = self.user
      notification.user = self.post.user
      notification.target = self
      notification.second_target = self.post
    end
  end 
end

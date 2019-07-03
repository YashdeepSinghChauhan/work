class Post < ApplicationRecord
    has_many_attached :images, dependent: :destroy
	searchkick
   extend FriendlyId
  friendly_id :title, use: :slugged
    has_and_belongs_to_many :tags, dependent: :destroy
    has_many :likes, dependent: :destroy
    is_impressionable
    acts_as_votable
    belongs_to :user
    validate :user_quota, :on => :create  
    belongs_to :category
    validates_presence_of :description
    has_many :comments, dependent: :destroy
    def code
  		self.description.split('/').last 
	end
    after_create do
        post = Post.find_by(id: self.id)
        hashtags = self.description.scan(/#\w+/)
        hashtags.map do |hashtag|
            tag = Tag.find_or_create_by(name: hashtag.downcase.delete('#'))
            post.tags << tag
        end
    end
     before_update do
        post = Post.find_by(id: self.id)
        post.tags.clear
        hashtags = self.description.scan(/#\w+/)
        hashtags.uniq.map do |hashtag|
            tag = Tag.find_or_create_by(name: hashtag.downcase.delete('#'))
            post.tags << tag
        end
    end
    
    
    def thumbnail input 
       return self.images[input].variant(resize: '300x300!').processed  
    end
   def mentions
       @mentions ||= begin
                        regex = /@([\w]+)/
                        matches = description.scan(regex).flatten
                    end
    end
    def mentioned_users
        @mentioned_users ||= User.where(username: mentions)
    end
  

private 
    def image_type 
        if images.attached == false
            errors.add(:images, "Please attach an image")
        end
        images.each do |image|
            if !image.content_type.in?(%('image/jpeg image/png'))
                errors.add(:images, "Upload a validate format image")
            end
        end
    end
    def user_quota
        if user.posts.today.count >= 1
            errors.add(:base, "Exceeds daily limit")
        end
    end
end

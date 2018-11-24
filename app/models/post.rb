class Post < ApplicationRecord
    has_and_belongs_to_many :tags
    has_many :likes
    is_impressionable
    acts_as_votable
    belongs_to :user
    validate :user_quota, :on => :create  
    belongs_to :category
    validates :description, length: { minimum: 400 }
    has_many :comments, dependent: :destroy
    has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }
    validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
    validates_presence_of :image
    validates_attachment_size :image, :in => 0.megabytes..5.megabytes
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
    

private 
    def user_quota
        if user.posts.today.count >= 1
            errors.add(:base, "Exceeds daily limit")
        end
    end
end

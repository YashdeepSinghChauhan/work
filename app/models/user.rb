class User < ApplicationRecord
  searchkick word_middle: [:username, :first_name]
   extend FriendlyId
  has_many :posts, dependent: :destroy do
    def today
      where(:created_at => (Time.zone.now.beginning_of_day..Time.zone.now))
    end
  end
  has_many :comments, dependent: :destroy
  has_attached_file :avatar,
    styles: { medium: '300x300>', thumb: '100x100>' }, :default_url => "default.jpg",
    processors: [:thumbnail, :compression]
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  validates_attachment_size :avatar, :in => 0.megabytes..5.megabytes
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  acts_as_follower
  acts_as_followable
  validates_uniqueness_of :username, case_sensitive: false
  validates_uniqueness_of :email
  friendly_id :username, use: :slugged
  has_many :likes
  def likes?(post)
    post.likes.where(user_id: id).any?
  end
   def sizethumb input 
       return self.post.images[input].variant(resize: '300x300!').processed  
    end
end

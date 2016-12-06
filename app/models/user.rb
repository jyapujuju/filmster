class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :reviews
  has_many :following_reletionships, class_name: "Releationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followed_reletionships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :foloowing_users, through: :following_reletionships, source: :followed_id
  has_many :followed_users, through: :followed_reletionships, source: :follower
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  mount_uploader :avatar, AvatarUploader

  def reviewed?(movie)
    reviews.each do |review|
      return true if review.movie_id == movie.id
    end

    return false
  end

end

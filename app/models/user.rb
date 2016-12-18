class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :reviews
  has_many :ballets, dependent: :destroy
  has_many :following_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followed_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :following_users, through: :following_relationships, source: :followed_id
  has_many :followed_users, through: :followed_relationships, source: :follower
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  mount_uploader :avatar, AvatarUploader

  def reviewed?(movie)
    reviews.each do |review|
      return true if review.movie_id == movie.id
    end

    return false
  end

  def following?(user)
    following_relationships.exists?(followed_id: user.id)
  end

  def follow(other_user)
    following_relationships.create(followed_id: other_user.id)
  end

  def unfollow(other_user)
    relationship = following_relationships.find_by(followed_id: other_user.id)
    relationship.destroy
  end

  def voted?(review)
    ballets.exists?(review: review)
  end

  def vote(review)
    ballets.create(review: review)
  end

  def devote(review)
    bad_vote = ballets.find_by(review: review)
    bad_vote.destroy
  end

end

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :reviews
  has_many :voting_ballets, class_name: "ballet", foreign_key: "user_id", dependent: :destroy
  has_many :voting_ballets, through: :voting_ballets, source: :user_id
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

  def voted?(user)
    voting_ballets.exists?(user_id: user.id)
  end

  def vote(other_user)
    voting_ballets.create(user_id: other_user.id)
  end

  def devote(other_user)
    bad_vote = voting_ballets.find_by(user_id: other_user.id)
    bad_vote.destroy
  end

end

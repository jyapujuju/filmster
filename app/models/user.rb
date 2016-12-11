class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :reviews

  has_many :upvoter_votings, class_name: "Voting", foreign_key: "upvoter_id", dependent: :destroy
  has_many :candidate_voting, class_name: "Voting", foreign_key: "candidate_id", dependent: :destroy
  has_many :upvoter_users, through: :upvoter_votings, source: :candidate_id
  has_many :candidate_users, through: :candidate_voting, source: :upvoter
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

  def vote(other_user)
    upvoter_voting.create(upvoter_id: other_user.id)
  end

  def devote(other_user)
    voting = upvoter_voting.find_by(candidate_id: other_user.id)
    voting.destroy
  end

  def follow(other_user)
    following_relationships.create(followed_id: other_user.id)
  end

  def unfollow(other_user)
    relationship = following_relationships.find_by(followed_id: other_user.id)
    relationship.destroy
  end


end

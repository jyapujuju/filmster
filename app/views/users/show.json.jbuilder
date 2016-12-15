json.id @user.id
json.username @user.username
json.avatar_url @user.avatar_url
json.reviews do
  json.array! @user.reviews do |review|
    json.movie review.movie, :title, :id, :year, :imdbrating, :imdbid, :poster
    json.comment review.comment
  end
end
json.following_relationships do
  json.array! @user.following_relationships do |following_relationship|
    json.user following_relationship.followed, :id, :username, :avatar_url
  end
end

json.followed_relationships do
  json.array! @user.followed_relationships do |followed_relationship|
    json.user followed_relationship.follower, :id, :username, :avatar_url
  end
end

# json.upvoter_votings do
#   json.array! @user.voting_ballets do |voting_ballet|
#     json.user voting_ballet.voting, :user_id, :review_id
#   end
# end

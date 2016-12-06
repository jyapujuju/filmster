json.id @user.id
json.username @user.username
json.avatar_url @user.avatar_url
json.reviews do
  json.array! @user.reviews do |review|
    json.movie review.movie, :title, :id, :year, :imdbrating, :imdbid, :poster
    json.comment review.comment
  end
end

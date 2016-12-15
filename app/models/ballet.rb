class Ballet < ActiveRecord::Base
  belongs_to :user
  belongs_to :review
  validates :user, uniqueness: {scope: :review}
  validates :review, uniqueness: {scope: :user}

end

class Voting < ActiveRecord::Base
  belongs_to :upvoter, class_name: "User"
  belongs_to :candidate, class_name: "User"

  validates :upvoter, :candidate, presence: true
  validates :candidate_id, uniqueness: {scope: :upvoter}
end

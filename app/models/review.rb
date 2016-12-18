class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :movie
  has_many :ballets
end

class Member < ApplicationRecord
  belongs_to :user
  belongs_to :room
  validates_uniqueness_of :user
end

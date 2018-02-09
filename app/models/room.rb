class Room < ApplicationRecord
  belongs_to :user
  has_many :members, :dependent => :delete_all
  has_many :users, through: :members

  def timestamp
    created_at.strftime('%H:%M:%S %d %B %Y')
  end
end

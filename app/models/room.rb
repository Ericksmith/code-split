class Room < ApplicationRecord
  belongs_to :user
  has_many :members
  has_many :users, through: :members
  # after_update_commit { CodeBroadcastJob.perform_later(self) }

  def timestamp
    created_at.strftime('%H:%M:%S %d %B %Y')
  end
end

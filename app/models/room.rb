class Room < ApplicationRecord
  belongs_to :user

  after_update_commit { CodeBroadcastJob.perform_later(self) }

  def timestamp
    created_at.strftime('%H:%M:%S %d %B %Y')
  end
end

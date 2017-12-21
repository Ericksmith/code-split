class CodeBroadcastJob < ApplicationJob
  queue_as :default

  def perform(room)
    puts "in perform"
    ActionCable.server.broadcast "rooms_#{room.id}_channel",
                                 code: room.code
  end
end
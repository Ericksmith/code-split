class CodeBroadcastJob < ApplicationJob
  queue_as :default

  def perform(room)
    ActionCable.server.broadcast("chat_rooms_#{room.id}_channel", code: room.code)
  end
end
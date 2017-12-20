class ChatRoomsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "rooms_#{params['room_id']}_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def updated_code(data)
    room = Room.find(params['room_id'])
    if room.update(code: data)
      redirect_to :back
    else
      flash[:errors] = room.errors.full_messages
      redirect_to :back
    end
  end
end
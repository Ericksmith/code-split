class RoomsChannel < ApplicationCable::Channel
  def subscribed
    room = Room.find(params[:room_id])
    stream_from room
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
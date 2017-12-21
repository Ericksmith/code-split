class RoomsChannel < ApplicationCable::Channel
  def subscribed
    room = Room.find(params[:room_id])
    stream_from room
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def test(data)
    puts 'in test'
  end

  def update_code(data)
    room = Room.find(data['room_id'])
    if room.update(code: data['code'])
      puts 'Updated code'
    else
      flash[:errors] = room.errors.full_messages
      puts flash[:errors]
    end
  end
end
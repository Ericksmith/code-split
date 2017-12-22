class RoomsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_rooms_#{params['room']}_channel"
    room = Room.find(params[:room])
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    puts "user unsubscribed*************************"
  end

  def update_code(data)
    puts "updating code *******************************"
    room = Room.find(data['room_id'])
    if room.update(code: data['code'])
    else
      flash[:errors] = room.errors.full_messages
      puts flash[:errors]
    end
  end

  def send_code(data)
    ActionCable.server.broadcast("chat_rooms_#{params[:room]}_channel", data)
  end

  def new_user(data)
    ActionCable.server.broadcast("chat_rooms_#{params[:room]}_channel", data)
  end

  def user_left(data)
    puts '********************************'
    puts "user leaving"
    ActionCable.server.broadcast("chat_rooms_#{params[:room]}_channel", data)
  end

  def change_user(data)
    ActionCable.server.broadcast("chat_rooms_#{params[:room]}_channel", data)
  end
end
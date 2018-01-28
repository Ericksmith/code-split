class RoomsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_rooms_#{params['room']}_channel"

  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    member = Member.find_by(user_id: current_user.id)
    if member.destroy
    else
      flash[:errors] = memeber.errors.full_messages
    end
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
    room = Room.find(params[:room])
    member = Member.new(user_id: current_user.id, room_id: room.id)
    if member.save
      members = Member.joins(:user).where(room_id: room.id)
      data[:all_users] = []
      members.each do |m|
         data[:all_users].push(m.user.name)
      end
      ActionCable.server.broadcast("chat_rooms_#{params[:room]}_channel", data)
    else
      flash[:errors] = member.errors.full_messages 
    end
  end

  def user_left(data)
    puts '********************************'
    puts "user leaving"
    ActionCable.server.broadcast("chat_rooms_#{params[:room]}_channel", data)
  end

  def change_user(data)
    ActionCable.server.broadcast("chat_rooms_#{params[:room]}_channel", data)
  end

  def chat_message(data)
    ActionCable.server.broadcast("chat_rooms_#{params[:room]}_channel", data)
  end
end
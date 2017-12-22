class RoomsController < ApplicationController
  def index
    @rooms = Room.all
    @vrooms = Vroom.where(:public => true).order("created_at DESC")
    @new_room = Vroom.new
    render layout: "two_column"
  end

  def show
    @room = Room.joins(:user).find(params[:id])
  end

  def create
    room = current_user.rooms.build(room_params)
    if room.save
      puts room.id
      flash[:success] = 'Chat room added!'
      if params[:special]
        render partial: "partials/rindex", locals: { room: room }
      else
        redirect_to room_path(room.id)
      end
    else
      flash[:errors] = room.errors.full_messages
      redirect_to :back
    end
  end

  def destroy
  end

  private
  def room_params
    params.require(:room).permit(:title)
  end
end

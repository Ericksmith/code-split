class RoomsController < ApplicationController
  def index
    @rooms = Room.all
    render :index
  end

  def show
    @room = Room.joins(:user).find(params[:id])
    render :show
  end

  def create
    room = current_user.rooms.build(room_params)
    if room.save
      puts room.id
      flash[:success] = 'Chat room added!'
      redirect_to room_path(room.id)
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

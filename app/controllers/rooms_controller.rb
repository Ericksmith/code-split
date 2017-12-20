class RoomsController < ApplicationController
  def index
    @rooms = Room.all
  end

  def show
    @room = Room.joins(:user).find(params[:id])
  end

  def create
    room = current_user.rooms.build(room_params)
    if room.save
      flash[:success] = 'Chat room added!'
      redirect_to rooms_path
    else
      flash[:errors] = room.errors.full_messages
      redirect_to :back
    end
  end

  def destroy
  end

  private
  def room_parms
    params.require(:room).permit(:title)
  end
end

class RoomsController < ApplicationController
  def index
    @rooms = Room.all
    render :index
  end

  def show
    @room = Room.joins(:user).find(params[:id])
    @language = "codemirror/mode/" + @room.language + "/" + @room.language
    render :show
  end

  def create
    room = current_user.rooms.build(room_params)
    room.typist = current_user.name
    if room.save
      flash[:success] = 'Chat room added!'
      redirect_to room_path(room.id)
    else
      flash[:errors] = room.errors.full_messages
      redirect_to :back
    end
  end

  def destroy
    room = Room.find(params[:id])
    if room.destroy
      redirect_to rooms_path
    else
      flash[:errors] = room.errors.full_messages
    end
  end

  private
  def room_params
    params.require(:room).permit(:title, :language)
  end
end

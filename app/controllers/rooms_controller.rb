class RoomsController < ApplicationController
  def index
    @rooms = Room.all
    render :index
  end

  def show
    @room = Room.joins(:user).find(params[:id])
    @language = "/assets/codemirror/mode/" + @room.language + "/" + @room.language + ".js"
    puts @language
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
    room = Room.find(params[:id])
    if room.destroy
      puts "room deleted"
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

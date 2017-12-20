class VroomsController < ApplicationController
  before_action :config_opentok,:except => [:index]
  def index
    @rooms = Vroom.where(:public => true).order("created_at DESC")
    @new_room = Vroom.new
  end

  def create
    session = @opentok.create_session :archive_mode => :always, :media_mode => :routed
    params[:vroom][:sessionId]= session.session_id
    puts session

    @new_room = Vroom.new(room_params)

    respond_to do |format|
      if @new_room.save
        format.html{redirect_to("/party/"+@new_room.id.to_s)}
      else
        format.html{render :controller => 'vrooms', :action => "index"}
      end
    end
  end

  def party
    @room = Vroom.find(params[:id])
    @tok_token = @opentok.generate_token :session_id =>@room.sessionId
  end
  private
  def config_opentok
    if @opentok.nil?
      @opentok = OpenTok::OpenTok.new 46026622, "21ecf192a93fc957b091e3d57f4191d612d23af8"
    end
  end
  def room_params
    params.require(:vroom).permit(:name, :public, :sessionId)
  end
end

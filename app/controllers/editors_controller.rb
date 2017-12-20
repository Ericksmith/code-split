class EditorsController < ApplicationController
  def index
    unless user_signed_in?
      redirect_to new_user_registration_path
    end
    
  end
end

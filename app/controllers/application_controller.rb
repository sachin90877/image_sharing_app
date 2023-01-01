class ApplicationController < ActionController::Base
  before_action :authenticate_user! , except: :check_bad_routes

  def check_bad_routes
    flash.notice = 'Invalid URL'
    redirect_to root_path
  end

end

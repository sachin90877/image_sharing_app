class HomeController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @photos = Photo.all.order('created_at DESC').limit(25)
  end
end

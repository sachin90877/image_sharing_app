class AlbumsController < ApplicationController
  before_action :set_album, only: %i[ show edit update destroy ]
  before_action :check_profile
  before_action :check_owner, only: [:edit, :update, :destroy]

  # GET /albums or /albums.json
  def index
    @albums = current_user.albums
  end

  # GET /albums/1 or /albums/1.json
  def show
  end

  # GET /albums/new
  def new
    @album = current_user.albums.new
  end

  # GET /albums/1/edit
  def edit
  end

  # POST /albums or /albums.json
  def create
    @album = current_user.albums.new(album_params)

    respond_to do |format|
      if @album.save
        format.html { redirect_to album_url(@album), notice: "Album was successfully created." }
        format.json { render :show, status: :created, location: @album }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /albums/1 or /albums/1.json
  def update
    respond_to do |format|
      if @album.update(album_params)
        format.html { redirect_to album_url(@album), notice: "Album was successfully updated." }
        format.json { render :show, status: :ok, location: @album }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /albums/1 or /albums/1.json
  def destroy
    @album.destroy

    respond_to do |format|
      format.html { redirect_to albums_url, notice: "Album was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_album
      @album = Album.find(params[:id])
    end

    def check_profile
      if !current_user.profile.name.present?
        redirect_to edit_profile_path(current_user.profile)
      end
    end

    def check_owner
     unless @album.user_id == current_user.id
      flash[:notice] = 'Access denied'
      redirect_to albums_path
     end
    end

    # Only allow a list of trusted parameters through.
    def album_params
      params.require(:album).permit(:name, :user_id, photos_attributes: [:image, :caption, :album_id])
    end
end

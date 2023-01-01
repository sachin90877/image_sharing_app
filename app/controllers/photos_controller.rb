class PhotosController < ApplicationController
  before_action :set_photo, only: %i[ show edit update destroy ]
  before_action :check_photo_count, only: %i[ new create ]
  before_action :check_user_authenticity, except: :index

  # GET /photos or /photos.json
  def index
    @photos = Photo.all
    @album = Album.find(params[:album_id])
  end

  # GET /photos/1 or /photos/1.json
  def show
  end

  # GET /photos/new
  def new
    @photo = @album.photos.build
  end

  def edit
  end

  def create
    @photo = Photo.new(photo_params.merge(album_id: @album.id))
    respond_to do |format|
      if @photo.save
        format.html { redirect_to album_photos_path(@album), notice: "Photo was successfully created." }
        format.json { render :show, status: :created, location: @photo }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @photo.update(photo_params)
        format.html { redirect_to album_photos_path(@album), notice: "Photo was successfully updated." }
        format.json { render :show, status: :ok, location: @photo }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @photo.destroy

    respond_to do |format|
      format.html { redirect_to album_photos_path, notice: "Photo was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      @photo = Photo.find(params[:id])
    end

    def check_photo_count
      if @photos.present? && @photos.count > 25
        redirect_to album_photos_path(@album), notice: "Limit Exceeded."
      end
    end

    def check_user_authenticity
      @album = Album.find(params[:album_id])
      if @album.user_id != current_user.id
        redirect_to album_photos_path(@album), notice: "Execess denied."
      end
    end

    # Only allow a list of trusted parameters through.
    def photo_params
      params.require(:photo).permit(:caption, :image ,:image_file_name)
    end
end

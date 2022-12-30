class PhotosController < ApplicationController
  before_action :set_photo, only: %i[ show edit update destroy ]

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
    @album = Album.find(params[:album_id])
    @photo = @album.photos.build
  end

  # GET /photos/1/edit
  def edit
    @album = Album.find(params[:album_id])
  end

  # POST /photos or /photos.json
  def create
    @album = Album.find(params[:album_id])
    @photo = Photo.new(photo_params.merge(album_id: @album.id))
    respond_to do |format|
      if @photo.save
        format.html { redirect_to album_photos_path(@photo), notice: "Photo was successfully created." }
        format.json { render :show, status: :created, location: @photo }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /photos/1 or /photos/1.json
  def update
    respond_to do |format|
      if @photo.update(photo_params)
        format.html { redirect_to album_photos_path(@photo), notice: "Photo was successfully updated." }
        format.json { render :show, status: :ok, location: @photo }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1 or /photos/1.json
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

    # Only allow a list of trusted parameters through.
    def photo_params
      params.require(:photo).permit(:caption, :image ,:image_file_name)
    end
end
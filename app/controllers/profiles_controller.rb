class ProfilesController < ApplicationController
  before_action :set_profile, only: %i[ show edit update destroy ]
  before_action :check_profile, except: %i[ edit update ]

  # GET /profiles or /profiles.json
  def index
    redirect_to current_user.profile
    # @profiles = Profile.all
  end

  # GET /profiles/1 or /profiles/1.json
  def show
  end

  # GET /profiles/new
  def new
    @profile = Profile.new
  end

  # GET /profiles/1/edit
  def edit
    @profile = current_user.profile
  end

  # POST /profiles or /profiles.json
  def create
    @profile = Profile.new(profile_params)

    respond_to do |format|
      if @profile.save
        format.html { redirect_to profile_url(@profile), notice: "Profile was successfully created." }
        format.json { render :show, status: :created, location: @profile }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profiles/1 or /profiles/1.json
  def update
      @profile = current_user.profile
    respond_to do |format|
      if @profile.update profile_params
        format.html { redirect_to profile_path(@profile), notice: "Profile updated!" }
        format.json { render :edit, status: :ok, location: @profile }
      else
        format.html { redirect_to edit_profile_path, flash: { error: "Profile could not be updated!" } }
        format.json { render json: @profile.errors.messages, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profiles/1 or /profiles/1.json
  def destroy
    @profile.destroy

    respond_to do |format|
      format.html { redirect_to profiles_url, notice: "Profile was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      @profile = Profile.find(params[:id])
    end

    def check_profile
      if !current_user.profile.name.present?
        flash.notice = 'First update your profile'
        redirect_to edit_profile_path(current_user.profile)
      end
    end

    # Only allow a list of trusted parameters through.
    def profile_params
      params.require(:profile).permit(:name)
    end
end

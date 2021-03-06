class ProfileColorsController < ApplicationController
  before_action :set_profile_color, only: %i[show edit update destroy]

  # GET /profile_colors or /profile_colors.json
  def index
    @profile_colors = ProfileColor.all
  end

  # GET /profile_colors/1 or /profile_colors/1.json
  def show
  end

  # GET /profile_colors/new
  def new
    @profile_color = ProfileColor.new
  end

  # GET /profile_colors/1/edit
  def edit
  end

  # POST /profile_colors or /profile_colors.json
  def create
    @profile_color = ProfileColor.new(profile_color_params)

    respond_to do |format|
      if @profile_color.save
        format.html { redirect_to @profile_color, notice: "Profile color was successfully created." }
        format.json { render :show, status: :created, location: @profile_color }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @profile_color.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profile_colors/1 or /profile_colors/1.json
  def update
    respond_to do |format|
      if @profile_color.update(profile_color_params)
        format.html { redirect_to @profile_color, notice: "Profile color was successfully updated." }
        format.json { render :show, status: :ok, location: @profile_color }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @profile_color.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profile_colors/1 or /profile_colors/1.json
  def destroy
    @profile_color.destroy
    respond_to do |format|
      format.html { redirect_to profile_colors_url, notice: "Profile color was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_profile_color
    @profile_color = ProfileColor.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def profile_color_params
    params.require(:profile_color).permit(:profile_id, :color)
  end
end

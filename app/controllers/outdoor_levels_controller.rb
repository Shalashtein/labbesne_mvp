class OutdoorLevelsController < ApplicationController
  before_action :set_outdoor_level, only: %i[show edit update destroy]

  # GET /outdoor_levels
  # GET /outdoor_levels.json
  def index
    @outdoor_levels = OutdoorLevel.all
  end

  # GET /outdoor_levels/1
  # GET /outdoor_levels/1.json
  def show
  end

  # GET /outdoor_levels/new
  def new
    @outdoor_level = OutdoorLevel.new
  end

  # GET /outdoor_levels/1/edit
  def edit
  end

  # POST /outdoor_levels
  # POST /outdoor_levels.json
  def create
    @outdoor_level = OutdoorLevel.new(outdoor_level_params)

    respond_to do |format|
      if @outdoor_level.save
        format.html { redirect_to @outdoor_level, notice: 'Outdoor level was successfully created.' }
        format.json { render :show, status: :created, location: @outdoor_level }
      else
        format.html { render :new }
        format.json { render json: @outdoor_level.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /outdoor_levels/1
  # PATCH/PUT /outdoor_levels/1.json
  def update
    respond_to do |format|
      if @outdoor_level.update(outdoor_level_params)
        format.html { redirect_to @outdoor_level, notice: 'Outdoor level was successfully updated.' }
        format.json { render :show, status: :ok, location: @outdoor_level }
      else
        format.html { render :edit }
        format.json { render json: @outdoor_level.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /outdoor_levels/1
  # DELETE /outdoor_levels/1.json
  def destroy
    @outdoor_level.destroy
    respond_to do |format|
      format.html { redirect_to outdoor_levels_url, notice: 'Outdoor level was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_outdoor_level
    @outdoor_level = OutdoorLevel.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def outdoor_level_params
    params.require(:outdoor_level).permit(:level)
  end
end

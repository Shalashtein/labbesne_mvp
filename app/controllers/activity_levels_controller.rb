class ActivityLevelsController < ApplicationController
  before_action :set_activity_level, only: %i[show edit update destroy]

  # GET /activity_levels
  # GET /activity_levels.json
  def index
    @activity_levels = ActivityLevel.all
  end

  # GET /activity_levels/1
  # GET /activity_levels/1.json
  def show
  end

  # GET /activity_levels/new
  def new
    @activity_level = ActivityLevel.new
  end

  # GET /activity_levels/1/edit
  def edit
  end

  # POST /activity_levels
  # POST /activity_levels.json
  def create
    @activity_level = ActivityLevel.new(activity_level_params)

    respond_to do |format|
      if @activity_level.save
        format.html { redirect_to @activity_level, notice: 'Activity level was successfully created.' }
        format.json { render :show, status: :created, location: @activity_level }
      else
        format.html { render :new }
        format.json { render json: @activity_level.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /activity_levels/1
  # PATCH/PUT /activity_levels/1.json
  def update
    respond_to do |format|
      if @activity_level.update(activity_level_params)
        format.html { redirect_to @activity_level, notice: 'Activity level was successfully updated.' }
        format.json { render :show, status: :ok, location: @activity_level }
      else
        format.html { render :edit }
        format.json { render json: @activity_level.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /activity_levels/1
  # DELETE /activity_levels/1.json
  def destroy
    @activity_level.destroy
    respond_to do |format|
      format.html { redirect_to activity_levels_url, notice: 'Activity level was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_activity_level
    @activity_level = ActivityLevel.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def activity_level_params
    params.require(:activity_level).permit(:name)
  end
end

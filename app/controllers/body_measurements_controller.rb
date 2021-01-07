class BodyMeasurementsController < ApplicationController
  before_action :set_body_measurement, only: [:show, :edit, :update, :destroy]

  # GET /body_measurements
  # GET /body_measurements.json
  def index
    if !current_spree_user.has_spree_role?(:admin)
      redirect_to '/profile'
    else
      @body_measurements = BodyMeasurement.all
    end
  end

  # GET /body_measurements/1
  # GET /body_measurements/1.json
  def show
    if !current_spree_user.has_spree_role?(:admin)
      redirect_to '/profile'
    else
      @body_measurements = BodyMeasurement.all
    end
  end

  # GET /body_measurements/new
  def new
    @body_measurement = BodyMeasurement.new
  end

  # GET /body_measurements/1/edit
  def edit
  end

  # POST /body_measurements
  # POST /body_measurements.json
  def create
    @body_measurement = BodyMeasurement.new(body_measurement_params)
    respond_to do |format|
      if @body_measurement.save
        format.html { redirect_to '/profile', notice: 'Measurements Saved' }
        format.json { render :show, status: :created, location: @body_measurement }
      else
        format.html { render :new }
        format.json { render json: @body_measurement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /body_measurements/1
  # PATCH/PUT /body_measurements/1.json
  def update
    respond_to do |format|
      if @body_measurement.update(body_measurement_params)
        format.html { redirect_to @body_measurement, notice: 'Body measurement was successfully updated.' }
        format.json { render :show, status: :ok, location: @body_measurement }
      else
        format.html { render :edit }
        format.json { render json: @body_measurement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /body_measurements/1
  # DELETE /body_measurements/1.json
  def destroy
    @body_measurement.destroy
    respond_to do |format|
      format.html { redirect_to body_measurements_url, notice: 'Body measurement was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_body_measurement
      @body_measurement = BodyMeasurement.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def body_measurement_params
      params.require(:body_measurement).permit(:profiles_id, :body_types_id, :height, :weight, :shirt_size, :pants_size, :shoe_size)
    end
end

class PreregistrationsController < ApplicationController
  before_action :set_preregistration, only: %i[show edit update destroy]

  # GET /preregistrations or /preregistrations.json
  def index
    @preregistrations = Preregistration.all
  end

  # GET /preregistrations/1 or /preregistrations/1.json
  def show
  end

  # GET /preregistrations/new
  def new
    @preregistration = Preregistration.new
  end

  # GET /preregistrations/1/edit
  def edit
  end

  # POST /preregistrations or /preregistrations.json
  def create
    @preregistration = Preregistration.new(preregistration_params)
    session[:email] = @preregistration.email
    respond_to do |format|
      if @preregistration.save
        format.html { redirect_to @preregistration, notice: "Preregistration was successfully created." }
        format.json { render :show, status: :created, location: @preregistration }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @preregistration.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /preregistrations/1 or /preregistrations/1.json
  def update
    respond_to do |format|
      if @preregistration.update(preregistration_params)
        format.html { redirect_to @preregistration, notice: "Preregistration was successfully updated." }
        format.json { render :show, status: :ok, location: @preregistration }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @preregistration.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /preregistrations/1 or /preregistrations/1.json
  def destroy
    @preregistration.destroy
    respond_to do |format|
      format.html { redirect_to preregistrations_url, notice: "Preregistration was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_preregistration
    @preregistration = Preregistration.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def preregistration_params
    params.require(:preregistration).permit(:email)
  end
end

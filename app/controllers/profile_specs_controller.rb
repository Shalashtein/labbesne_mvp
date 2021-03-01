class ProfileSpecsController < ApplicationController
  before_action :set_profile_spec, only: %i[show edit update destroy]

  # GET /profile_specs
  # GET /profile_specs.json
  def index
    @profile_specs = ProfileSpec.all
  end

  # GET /profile_specs/1
  # GET /profile_specs/1.json
  def show
  end

  # GET /profile_specs/new
  def new
    @profile_spec = ProfileSpec.new
  end

  # GET /profile_specs/1/edit
  def edit
  end

  # POST /profile_specs
  # POST /profile_specs.json
  def create
    @profile_spec = ProfileSpec.new(profile_spec_params)

    respond_to do |format|
      if @profile_spec.save
        format.html { redirect_to @profile_spec, notice: 'Profile spec was successfully created.' }
        format.json { render :show, status: :created, location: @profile_spec }
      else
        format.html { render :new }
        format.json { render json: @profile_spec.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profile_specs/1
  # PATCH/PUT /profile_specs/1.json
  def update
    respond_to do |format|
      if @profile_spec.update(profile_spec_params)
        format.html { redirect_to @profile_spec, notice: 'Profile spec was successfully updated.' }
        format.json { render :show, status: :ok, location: @profile_spec }
      else
        format.html { render :edit }
        format.json { render json: @profile_spec.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profile_specs/1
  # DELETE /profile_specs/1.json
  def destroy
    @profile_spec.destroy
    respond_to do |format|
      format.html { redirect_to profile_specs_url, notice: 'Profile spec was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_profile_spec
    @profile_spec = ProfileSpec.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def profile_spec_params
    params.require(:profile_spec).permit(:profiles_id, :specs_id, :value)
  end
end

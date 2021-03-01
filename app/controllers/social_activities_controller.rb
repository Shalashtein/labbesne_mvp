class SocialActivitiesController < ApplicationController
  before_action :set_social_activity, only: %i[show edit update destroy]

  # GET /social_activities
  # GET /social_activities.json
  def index
    @social_activities = SocialActivity.all
  end

  # GET /social_activities/1
  # GET /social_activities/1.json
  def show
  end

  # GET /social_activities/new
  def new
    @social_activity = SocialActivity.new
  end

  # GET /social_activities/1/edit
  def edit
  end

  # POST /social_activities
  # POST /social_activities.json
  def create
    @social_activity = SocialActivity.new(social_activity_params)

    respond_to do |format|
      if @social_activity.save
        format.html { redirect_to @social_activity, notice: 'Social activity was successfully created.' }
        format.json { render :show, status: :created, location: @social_activity }
      else
        format.html { render :new }
        format.json { render json: @social_activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /social_activities/1
  # PATCH/PUT /social_activities/1.json
  def update
    respond_to do |format|
      if @social_activity.update(social_activity_params)
        format.html { redirect_to @social_activity, notice: 'Social activity was successfully updated.' }
        format.json { render :show, status: :ok, location: @social_activity }
      else
        format.html { render :edit }
        format.json { render json: @social_activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /social_activities/1
  # DELETE /social_activities/1.json
  def destroy
    @social_activity.destroy
    respond_to do |format|
      format.html { redirect_to social_activities_url, notice: 'Social activity was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_social_activity
    @social_activity = SocialActivity.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def social_activity_params
    params.require(:social_activity).permit(:name)
  end
end

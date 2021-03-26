class InfosController < ApplicationController
  before_action :set_info, only: %i[show edit update destroy]

  # GET /infos
  # GET /infos.json
  def index
    @infos = Info.all
  end

  # GET /infos/1
  # GET /infos/1.json
  def show
  end

  # GET /infos/new
  def new
    @info = Info.new
  end

  # GET /infos/1/edit
  def edit
  end

  # POST /infos
  # POST /infos.json
  def create
    @info = Info.new(info_params)

    respond_to do |format|
      if @info.save
        if current_spree_user.ship_address.nil?
          @address = Spree::Address.create(first_name: @info.name.split(' ').first,
                                           last_name: @info.name.split(' ').last, city: '..', address1: '..', zipcode: 'N/A', phone: @info.phone, state_name: '', country_id: 127, state_id: 1)
          @address.save!
          a = Spree::UserAddress.new(user_id: current_spree_user.id, address_id: @address.id, default: true,
                                     default_billing: true)
          a.save!
        else
          a = current_spree_user.ship_address
          a.phone = @info.phone
          a.first_name = @info.name.split(' ').first
          a.last_name = @info.name.split(' ').last
          a.save!
        end
        format.html { redirect_to profile_router_path, notice: 'Info saved.' }
        format.json { render :show, status: :created, location: @info }
        format.js { head :ok}
      else
        format.html { render :new }
        format.json { render json: @info.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /infos/1
  # PATCH/PUT /infos/1.json
  def update
    respond_to do |format|
      if @info.update(info_params)
        format.html { redirect_to profile_router_path, notice: 'Info updated.' }
        format.json { render json: @info.to_json, status: :ok }
        format.js { head :ok}
      else
        format.html { render :edit }
        format.json { render json: @info.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /infos/1
  # DELETE /infos/1.json
  def destroy
    @info.destroy
    respond_to do |format|
      format.html { redirect_to infos_url, notice: 'Info was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_info
    @info = Info.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def info_params
    params.require(:info).permit(:profiles_id, :name, :dob, :gender, :phone)
  end
end

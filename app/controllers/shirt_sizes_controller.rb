class ShirtSizesController < ApplicationController
  before_action :set_shirt_size, only: %i[show edit update destroy]

  # GET /shirt_sizes
  # GET /shirt_sizes.json
  def index
    @shirt_sizes = ShirtSize.all
  end

  # GET /shirt_sizes/1
  # GET /shirt_sizes/1.json
  def show
  end

  # GET /shirt_sizes/new
  def new
    @shirt_size = ShirtSize.new
  end

  # GET /shirt_sizes/1/edit
  def edit
  end

  # POST /shirt_sizes
  # POST /shirt_sizes.json
  def create
    @shirt_size = ShirtSize.new(shirt_size_params)

    respond_to do |format|
      if @shirt_size.save
        format.html { redirect_to @shirt_size, notice: 'Shirt size was successfully created.' }
        format.json { render :show, status: :created, location: @shirt_size }
      else
        format.html { render :new }
        format.json { render json: @shirt_size.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shirt_sizes/1
  # PATCH/PUT /shirt_sizes/1.json
  def update
    respond_to do |format|
      if @shirt_size.update(shirt_size_params)
        format.html { redirect_to @shirt_size, notice: 'Shirt size was successfully updated.' }
        format.json { render :show, status: :ok, location: @shirt_size }
      else
        format.html { render :edit }
        format.json { render json: @shirt_size.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shirt_sizes/1
  # DELETE /shirt_sizes/1.json
  def destroy
    @shirt_size.destroy
    respond_to do |format|
      format.html { redirect_to shirt_sizes_url, notice: 'Shirt size was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_shirt_size
    @shirt_size = ShirtSize.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def shirt_size_params
    params.require(:shirt_size).permit(:size)
  end
end

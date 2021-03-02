class ShoeSizesController < ApplicationController
  before_action :set_shoe_size, only: %i[show edit update destroy]

  # GET /shoe_sizes
  # GET /shoe_sizes.json
  def index
    @shoe_sizes = ShoeSize.all
  end

  # GET /shoe_sizes/1
  # GET /shoe_sizes/1.json
  def show
  end

  # GET /shoe_sizes/new
  def new
    @shoe_size = ShoeSize.new
  end

  # GET /shoe_sizes/1/edit
  def edit
  end

  # POST /shoe_sizes
  # POST /shoe_sizes.json
  def create
    @shoe_size = ShoeSize.new(shoe_size_params)

    respond_to do |format|
      if @shoe_size.save
        format.html { redirect_to @shoe_size, notice: 'Shoe size was successfully created.' }
        format.json { render :show, status: :created, location: @shoe_size }
      else
        format.html { render :new }
        format.json { render json: @shoe_size.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shoe_sizes/1
  # PATCH/PUT /shoe_sizes/1.json
  def update
    respond_to do |format|
      if @shoe_size.update(shoe_size_params)
        format.html { redirect_to @shoe_size, notice: 'Shoe size was successfully updated.' }
        format.json { render :show, status: :ok, location: @shoe_size }
      else
        format.html { render :edit }
        format.json { render json: @shoe_size.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shoe_sizes/1
  # DELETE /shoe_sizes/1.json
  def destroy
    @shoe_size.destroy
    respond_to do |format|
      format.html { redirect_to shoe_sizes_url, notice: 'Shoe size was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_shoe_size
    @shoe_size = ShoeSize.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def shoe_size_params
    params.require(:shoe_size).permit(:EUR)
  end
end

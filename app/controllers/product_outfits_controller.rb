class ProductOutfitsController < ApplicationController
  before_action :set_product_outfit, only: %i[ show edit update destroy ]

  # GET /product_outfits or /product_outfits.json
  def index
    @product_outfits = ProductOutfit.all
  end

  # GET /product_outfits/1 or /product_outfits/1.json
  def show
  end

  # GET /product_outfits/new
  def new
    @product_outfit = ProductOutfit.new
  end

  # GET /product_outfits/1/edit
  def edit
  end

  # POST /product_outfits or /product_outfits.json
  def create
    @product_outfit = ProductOutfit.new(product_outfit_params)

    respond_to do |format|
      if @product_outfit.save
        format.html { redirect_to @product_outfit, notice: "Product outfit was successfully created." }
        format.json { render :show, status: :created, location: @product_outfit }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product_outfit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /product_outfits/1 or /product_outfits/1.json
  def update
    respond_to do |format|
      if @product_outfit.update(product_outfit_params)
        format.html { redirect_to @product_outfit, notice: "Product outfit was successfully updated." }
        format.json { render :show, status: :ok, location: @product_outfit }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product_outfit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /product_outfits/1 or /product_outfits/1.json
  def destroy
    @product_outfit.destroy
    respond_to do |format|
      format.html { redirect_to product_outfits_url, notice: "Product outfit was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product_outfit
      @product_outfit = ProductOutfit.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_outfit_params
      params.require(:product_outfit).permit(:spree_product_id, :outfit_id)
    end
end

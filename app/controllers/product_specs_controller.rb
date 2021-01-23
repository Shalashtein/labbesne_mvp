class ProductSpecsController < ApplicationController
  before_action :set_product_spec, only: [:show, :edit, :update, :destroy]

  # GET /product_specs
  # GET /product_specs.json
  def index
    @product_specs = ProductSpec.all
  end

  def populate
    @product = Spree::Product.find(params[:spree_product_id])
    @product_type = ProductSpec.where(spree_product_id: params[:spree_product_id], specs_id: Spec.where(name: 'clothing-type')).first
    @product_spec = ProductSpec.new
    @specs = Spec.all
  end

  def popsave
    if !ProductSpec.where(spree_product_id: params[:spree_product_id], specs_id: params[:specs_id]).exists?
      product_spec = ProductSpec.new(product_spec_params)
      product_spec.name = Spec.find(product_spec.specs_id).name
      product_spec.value = Spec.find(product_spec.specs_id).value
    end
    respond_to do |format|
      if product_spec.save
        @product = Spree::Product.find(product_spec.spree_product_id)
        format.html { redirect_to populate_path(spree_product_id: @product.id), notice: 'Product specs updated.' }
        format.json { render :show, status: :created, location: populate_path(spree_product_id: @product.id) }
      else
        format.html { render :populate }
        format.json { render json: product_spec.errors, status: :unprocessable_entity }
      end
    end
  end

  def reset
    ProductSpec.where(spree_product_id: params[:spree_product_id]).each do |ps|
      ps.destroy
    end
    redirect_to populate_path(spree_product_id: params[:spree_product_id]), notice: 'Product specs cleared.'
  end

  # GET /product_specs/1
  # GET /product_specs/1.json
  def show
  end

  # GET /product_specs/new
  def new
    @product_spec = ProductSpec.new
  end

  # GET /product_specs/1/edit
  def edit
  end

  # POST /product_specs
  # POST /product_specs.json
  def create
    @product_spec = ProductSpec.new(product_spec_params)

    respond_to do |format|
      if @product_spec.save
        format.html { redirect_to @product_spec, notice: 'Product spec was successfully created.' }
        format.json { render :show, status: :created, location: @product_spec }
      else
        format.html { render :new }
        format.json { render json: @product_spec.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /product_specs/1
  # PATCH/PUT /product_specs/1.json
  def update
    respond_to do |format|
      if @product_spec.update(product_spec_params)
        format.html { redirect_to @product_spec, notice: 'Product spec was successfully updated.' }
        format.json { render :show, status: :ok, location: @product_spec }
      else
        format.html { render :edit }
        format.json { render json: @product_spec.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /product_specs/1
  # DELETE /product_specs/1.json
  def destroy
    @product_spec.destroy
    respond_to do |format|
      format.html { redirect_to product_specs_url, notice: 'Product spec was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product_spec
      @product_spec = ProductSpec.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_spec_params
      params.require(:product_spec).permit(:spree_product_id, :specs_id)
    end
end

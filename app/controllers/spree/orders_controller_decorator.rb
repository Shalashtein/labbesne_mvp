module Spree::OrdersControllerDecorator
  def populate
    @order = current_order(create_order_if_necessary: true)
    authorize! :update, @order, cookies.signed[:guest_token]

    variant  = Spree::Variant.find(params[:variant_id])
    quantity = params[:quantity].present? ? params[:quantity].to_i : 1

    # 2,147,483,647 is crazy. See issue https://github.com/spree/spree/issues/2695.
    if quantity.between?(1, 2_147_483_647)
      begin
        @line_item = @order.contents.add(variant, quantity)
      rescue ActiveRecord::RecordInvalid => e
        @order.errors.add(:base, e.record.errors.full_messages.join(", "))
      end
    else
      @order.errors.add(:base, t('spree.please_enter_reasonable_quantity'))
    end

    respond_with(@order) do |format|
      format.html do
        if @order.errors.any?
          flash[:error] = @order.errors.full_messages.join(", ")
          redirect_back_or_default(spree.root_path)
          return
        else
          # redirect_to cart_path
          render json: @order
        end
      end
      format.json do
        # redirect_to cart_path
        render json: @order
      end
    end
  end

  Spree::OrdersController.prepend self
end

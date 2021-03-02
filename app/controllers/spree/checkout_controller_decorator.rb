module Spree::CheckoutControllerDecorator
  def finalize_order
    @current_order.line_items.each do |item|
      t = Track.new(spree_line_item_id: item.id, vendor_recieved: false, vendor_sent: false, recieved: false,
                    quantity: item.quantity, spree_user_id: Spree::Product.find(Spree::Variant.find(item.variant_id).product_id).spree_user_id)
      t.save!
    end
    @current_order = nil
    set_successful_flash_notice
    redirect_to completion_route
  end

  Spree::CheckoutController.prepend self
end

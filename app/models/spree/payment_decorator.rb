module Spree::PaymentDecorator
  def invalidate_old_payments
    if !store_credit? && !['invalid', 'failed'].include?(state)
      order.payments.select do |payment|
        payment.state == 'checkout' && !payment.store_credit? && payment.id != id && !payment.payment_method_id == Spree::PaymentMethod.find_by(name: "Cash on Delivery").id
      end.each(&:invalidate!)
    end
  end

  Spree::Payment.prepend self
end

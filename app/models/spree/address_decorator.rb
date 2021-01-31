module Spree::AddressDecorator

  def readonly?
    false
  end

Spree::Address.prepend self
end

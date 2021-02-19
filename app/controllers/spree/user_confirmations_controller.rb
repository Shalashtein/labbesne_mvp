# frozen_string_literal: true

class Spree::UserConfirmationsign_in(resource)
  helper 'spree/base', 'spree/store'

  include Spree::Core::ControllerHelpers::Auth
  include Spree::Core::ControllerHelpers::Common
  include Spree::Core::ControllerHelpers::Order
  include Spree::Core::ControllerHelpers::Store

  protected

  def after_confirmation_path_for(resource_name, resource)
    sign_in(resource)
    signed_in?(resource_name) ? main_app.root_path : main_app.confirmation_path
  end
end

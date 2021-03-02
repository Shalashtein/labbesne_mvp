module Spree::Admin::RootControllerDecorator
  def index
    if !current_spree_user.has_spree_role?(:admin) && !current_spree_user.has_spree_role?(:vendor)
      redirect_to '/'
    else
      redirect_to admin_root_redirect_path
    end
  end
  Spree::Admin::RootController.prepend self
end

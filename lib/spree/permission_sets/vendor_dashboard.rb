module Spree
  module PermissionSets
    class VendorDashboard < PermissionSets::Base
      def activate!
        can [:admin, :home], :dashboards
        can [:manage, :admin, :vendor, :tracks], Spree::Product, spree_user_id: user.id
        can [:read, :admin, :edit, :destroy, :create], Spree::Image
        can [:vendor, :tracks], :all
        can [:new, :create], Spree::Product
      end
    end
  end
end

module Spree
  module PermissionSets
    class VendorDashboard < PermissionSets::Base
      def activate!
        can [:admin, :home], :dashboards
        can [:read, :admin, :edit, :destroy, :vendor, :manage], Spree::Product, spree_user_id: user.id
        can [:read, :admin, :edit, :destroy, :create], Spree::Image
        can :vendor, :all
        can [:new, :create], Spree::Product
      end
    end
  end
end

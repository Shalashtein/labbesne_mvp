module Spree
  module PermissionSets
    class VendorDashboard < PermissionSets::Base
      def activate!
        can :manage, Spree::Product
      end
    end
  end
end

Rails.application.routes.draw do
  resources :tracks
  # This line mounts Solidus's routes at the root of your application.
  # This means, any requests to URLs such as /products, will go to Spree::ProductsController.
  # If you would like to change where this engine is mounted, simply change the :at option to something different.
  #
  # We ask that you don't use the :as option here, as Solidus relies on it being the default of "spree"
  mount Spree::Core::Engine, at: '/shop'

  mount SolidusPaypalCommercePlatform::Engine, at: '/solidus_paypal_commerce_platform'
  get '/vendor', to: 'pages#vendorDashboard'
  get '/admin/unapproved', to: 'spree/admin/products#unapproved'
  get '/admin/vendor', to: 'spree/admin/products#vendor'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

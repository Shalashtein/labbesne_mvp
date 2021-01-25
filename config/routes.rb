Rails.application.routes.draw do
  resources :infos
  root to: 'pages#store'
  resources :product_specs
  resources :profile_specs
  resources :specs
  resources :lifestyles
  resources :body_measurements
  resources :social_activities
  resources :outdoor_levels
  resources :job_types
  resources :activity_levels
  resources :shoe_sizes
  resources :shirt_sizes
  resources :body_types
  resources :profiles
  resources :tracks

  get '/unapproved', to: 'spree/admin/products#unapproved'
  get '/vendor', to: 'spree/admin/products#vendor'
  get '/vendor/orders', to: 'spree/admin/products#tracks'
  patch '/vendor/orders/:id/vendorRecieved', to: 'tracks#vendorRecieved', as: 'vendor_recieved'
  patch '/vendor/orders/:id/vendorSent', to: 'tracks#vendorSent', as: 'vendor_sent'
  patch '/vendor/orders/:id/Recieved',to: 'tracks#Recieved', as: 'recieved'
  get '/profileforms', to: 'pages#profileRouter', as: 'profile_router'
  get '/profile/measurements', to: 'pages#measurements'
  get '/profile/swipe', to: 'pages#swipepage', as: 'swipe'
  get '/store', to: 'pages#store', as: 'store'
  get '/shop/admin/product_specs', to: 'product_specs#populate', as: 'populate'
  post '/shop/admin/product_specs', to: 'product_specs#popsave', as: 'popsave'
  delete '/shop/admin/product_specs/:spree_product_id', to: 'product_specs#reset', as: 'popreset'
  post '/preferenceAdd', to: 'pages#preference', as: 'add_preference'
  delete '/cart/removeItem', to: 'pages#removeItem', as: 'remove_item'
  delete '/cart/empty', to: 'pages#emptyCart', as: 'empty_cart'
  get '/current_cart', to: 'pages#returnCart', as: 'current_cart'
  # This line mounts Solidus's routes at the root of your application.
  # This means, any requests to URLs such as /products, will go to Spree::ProductsController.
  # If you would like to change where this engine is mounted, simply change the :at option to something different.
  #
  # We ask that you don't use the :as option here, as Solidus relies on it being the default of "spree"
  mount Spree::Core::Engine, at: '/shop'

  mount SolidusPaypalCommercePlatform::Engine, at: '/shop/solidus_paypal_commerce_platform'
end

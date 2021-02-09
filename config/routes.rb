Rails.application.routes.draw do
  resources :preregistrations
  resources :interactions
  resources :product_outfits
  resources :outfits
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

  get '/touchdown', to: 'pages#landing', as: 'landing'
  get '/unapproved', to: 'spree/admin/products#unapproved'
  get '/vendor', to: 'spree/admin/products#vendor'
  get '/vendor/orders', to: 'spree/admin/products#tracks'
  patch '/vendor/orders/:id/vendorRecieved', to: 'tracks#vendorRecieved', as: 'vendor_recieved'
  patch '/vendor/orders/:id/vendorSent', to: 'tracks#vendorSent', as: 'vendor_sent'
  patch '/vendor/orders/:id/recieved', to: 'tracks#recieved', as: 'recieved'
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
  get '/deck', to: 'pages#deck', as: 'deck'
  get '/stylist', to: 'pages#stylist', as: 'stylist'
  get '/stylist/outfits', to: 'pages#stylist_outfits_area', as: 'stylist_outfits'
  get '/stylist/products', to: 'pages#stylist_products_area', as: 'stylist_products'
  get 'stylist/products/:filter', to: 'pages#stylist_filter', as: 'stylist_filter'
  get '/closet', to: 'pages#customer', as:'customer_dashboard'
  get '/closet/orders', to: 'pages#customerOrders', as:'customer_orders'
  get '/closet/products', to: 'pages#customerProducts', as:'customer_products'
  get '/closet/saved', to: 'pages#customerSaved', as:'customer_saved'
  get '/closet/unsave', to: 'pages#unsave'
  get 'closet/cart', to: 'pages#closet_cart'
  get '/expanded', to: 'pages#expandedInfo', as:'expanded'
  post '/save_product/', to: 'pages#saveProduct', as: 'save_product'
  get '/order/address', to: 'pages#updateAddress', as:'update_address'
  get '/order/checkout', to: 'pages#checkout', as: 'checkout'
  get '/order/confirm', to: 'pages#confirm', as: 'confirm'
  get '/order/saved', to: 'pages#savedAddress', as: 'saved_address'
  get '/order/finalize', to: 'pages#finalize', as: 'finalize_order'
  get '/guestSwiped', to: 'pages#guestSwiped'
  post '/popupmessage', to: 'pages#popupMessage', as: 'message'
  get '/vendor/dashboard', to: 'pages#vendor', as: 'vendor_dashboard'

  # This line mounts Solidus's routes at the root of your application.
  # This means, any requests to URLs such as /products, will go to Spree::ProductsController.
  # If you would like to change where this engine is mounted, simply change the :at option to something different.
  #
  # We ask that you don't use the :as option here, as Solidus relies on it being the default of "spree"
  mount Spree::Core::Engine, at: '/shop'

  mount SolidusPaypalCommercePlatform::Engine, at: '/shop/solidus_paypal_commerce_platform'
end

window.dynamicShop = function(){
  $(document).on('ajax:success','.next_deck', {} ,function(e){
    $('.dynamic-deck').load($('.next_deck').attr('href'));
  });
  // Dynamic Add to Cart Button
  $('#edit_order_10').bind('ajax:success', function(e){
    $('.dynamic_cart').load('/current_cart');
  });
  // Removing Items from Cart dynamically
  $(document).on('ajax:success','.empty_cart', {} ,function(e){
    $('.dynamic_cart').load('/current_cart');
  });
  $(document).on('ajax:success','.remove_item', {} ,function(e){
    $('.dynamic_cart').load('/current_cart');
  });
}

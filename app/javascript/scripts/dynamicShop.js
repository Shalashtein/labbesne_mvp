window.dynamicShop = function(){
  $(document).on('ajax:success','.next_deck', {} ,function(e){
    $('#loading').addClass('hidden')
    //$('.dynamic-deck').load($('.next_deck').attr('href'));
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
  $(document).on('click','.save_product_button', {} ,function(e){
    console.log($('#products-swipe-card-stack li:last-child').data("name"))
    console.log($('#products-swipe-card-stack li:last-child').data("saved"))
    $.post( `/save_product/?product=${$('#products-swipe-card-stack li:last-child').data("productid")}&action_id=${$('.save_product_button').hasClass('save_product_button_saved')}`, function(data) {
      if($('#products-swipe-card-stack li:last-child').data("saved")){
        $('.save_product_button').removeClass('save_product_button_saved')
        $('.save_product_button').html('Save for later')
        $('#products-swipe-card-stack li:last-child').data("saved", false)
      } else {
        $('.save_product_button').addClass('save_product_button_saved')
        $('.save_product_button').html('Saved')
        $('#products-swipe-card-stack li:last-child').data("saved", true)
      }
    });
  });
}

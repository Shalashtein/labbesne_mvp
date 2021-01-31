window.dynamicShop = function(){
  $(document).on('ajax:success','.next_deck', {} ,function(e){
    $('#loading').addClass('hidden')
    //$('.dynamic-deck').load($('.next_deck').attr('href'));
  });
  // Dynamic Add to Cart Button
  $('#add_to_cart').bind('ajax:success', function(e){
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
    $.post( `/save_product/?product=${$('#products-swipe-card-stack li:last-child').data("productid")}&action_id=${$('#products-swipe-card-stack li:last-child').data("saved")}`, function(data) {
      if($('#products-swipe-card-stack li:last-child').data("saved")){
        console.log("unsaving")
        $('.save_product_button').removeClass('save_product_button_saved')
        $('.save_product_button').html('Save for later')
        $('#products-swipe-card-stack li:last-child').removeClass('saved_product')
        $('#products-swipe-card-stack li:last-child').data("saved", "false")
      } else {
        console.log("saving")
        $('.save_product_button').addClass('save_product_button_saved')
        $('.save_product_button').html('Saved')
        $('#products-swipe-card-stack li:last-child').addClass('saved_product')
        $('#products-swipe-card-stack li:last-child').data("saved", "true")
      }
    });
  });
  $(document).on('click', '#checkout-btn', {}, function(){
    $.get('/order/checkout', function(data){
      if(data["value"] == "none"){
        alert("Please fill out your profile before ordering.")
      } else if(data["value"] == "incomplete"){
        $('#map-section').removeClass('hidden-map')
        map.resize();
        setTimeout(function(){
          $('html, body').animate({
                scrollTop: $("#map-section").offset().top
            }, 0);
        }, 100);
      } else {
        $('.address_prompt').show();
      }
    });
  });
  $(document).on('click', '.btn-cancel-checkout', {}, function(){
    $('#map-section').addClass('hidden-map')
  });
  $(document).on('click', '.btn-confirm-address', {}, function(){
    if(typeof current_marker == "undefined"){
        alert('Please select your delivery destination on the map');
    } else {
      if($('#delivery_street').val().length == 0){
         alert('Street Name cannot be empty');
      } else {
        if($('#delivery_building').val().length == 0){
         alert('Building Name cannot be empty');
        } else {
          if($('#delivery_floor').val().length == 0){
           alert('Floor Number cannot be empty');
          } else {
            alert('All Clear');
          }
        }
      }
    }
  });
}

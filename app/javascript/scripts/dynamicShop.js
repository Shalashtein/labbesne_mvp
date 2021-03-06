window.dynamicShop = function(){
  $(document).on('ajax:success','.next_deck', {} ,function(e){
    $('#loading').addClass('hidden')
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
  $(document).on('click','.save_product_button_main', {} ,function(e){
    $.post( `/save_product/?product=${$('#products-swipe-card-stack li:last-child').data("productid")}&action_id=${$('#products-swipe-card-stack li:last-child').data("saved")}`, function(data) {
      if(!data){
        console.log("unsaving")
        $('.save_product_button_main').removeClass('save_product_button_saved')
        $('.save_product_button_main').html('Save for later')
        $('#products-swipe-card-stack li:last-child').removeClass('saved_product')
        $('#products-swipe-card-stack li:last-child').data("saved", "false")
      } else {
        $('.save_product_button_main').addClass('save_product_button_saved')
        $('.save_product_button_main').html('Saved')
        $('#products-swipe-card-stack li:last-child').addClass('saved_product')
        $('#products-swipe-card-stack li:last-child').data("saved", "true")
      }
    });
  });
  $(document).on('click', '#checkout-btn', {}, function(){
    $.get('/order/checkout', function(data){
      if(data["value"] == "none"){
        $('.profile_prompt').show();
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
  $(document).on('click', '.use_cancel', {}, function(){
    $('.address_prompt').hide();
  });
  $(document).on('click', '.use_old', {}, function(){
    $.get('/order/saved', function(data){
      $('.address_prompt').hide();
      $('#confirmation-body').load('/order/confirm');
      $('#confirmation_trigger').click();
    });
  });
  $(document).on('click', '.use_new', {}, function(){
    $('.address_prompt').hide();
    $('#map-section').removeClass('hidden-map')
    map.resize();
    setTimeout(function(){
    $('html, body').animate({scrollTop: $("#map-section").offset().top}, 0);
    }, 100);
  });
  $(document).on('click', '.btn-cancel-checkout', {}, function(){
    $('#map-section').addClass('hidden-map')
  });
  $(document).on('click', '#finalize_order', {}, function(){
    $.get('/order/finalize',function(data){
      $('.dynamic_cart').load('/current_cart');
      $([document.documentElement, document.body]).animate({
          scrollTop: $("#products-section").offset().top
      }, 0);
      var confirmation_modal = new bootstrap.Modal(document.getElementById("staticBackdrop"), {});
      $('.close_confirmation_modal').click();
      $('#map-section').addClass('hidden-map')
      $.post('/popupmessage/?message=orderdone',function(){
        $('.products-container-sidebar').removeClass('sidebar-active')
        $('.products-container-cart').removeClass('cart-active')
        $('.message_box').removeClass('popup_hidden');
        $('#popup_close').click(function(){
          $('#message_box').addClass('popup_hidden');
        });
        $('.message_box').click(function(){
          $('.message_box').addClass('popup_hidden');
        });
        setTimeout(function(){
         $('.message_box').addClass('popup_hidden');
        }, 3000);
      });
    })
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
            var geocoded_address_req = `https://us1.locationiq.com/v1/reverse.php?key=pk.6bee3c8a67635229ef023dba06237acb&lat=${current_marker.getLngLat().lat}&lon=${current_marker.getLngLat().lng}&format=json`
            $.get(geocoded_address_req, function(data){
              var geocoded_string = ""
              for (var x in data["address"]){
                  geocoded_string += x + " " + data["address"][x] + " "
              }
              var address2 = `Street Name: ${$('#delivery_street').val()}, Building Name: ${$('#delivery_building').val()}, Floor: ${$('#delivery_floor').val()} `
              var req = $('.btn-confirm-address').data('path') + `?geo=${geocoded_string}&address2=${address2}&instructions=${$('#delivery_instruction').val()}&lat=${current_marker.getLngLat().lat}&lng=${current_marker.getLngLat().lng}`
              $.get(req, function(data){
                console.log(data)
                $('#confirmation-body').load('/order/confirm');
                $('#confirmation_trigger').click();
              });
              });
          }
        }
      }
    }
  });
}

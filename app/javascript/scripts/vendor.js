window.vendor = function(){
  $(document).on('click','.vendor_mark_ready', {} ,function(e){
    shipment = $(this).data('s')
    req = `/vendor/order_ready?s=${shipment}`

    $.post(req, function(){
      req = `/vendor/slip?s=${shipment}`
      window.open(req)
    })
  });
  $(document).on('click','.vendor_tab', {} ,function(e){
    $('.vendor_tab').removeClass('vendor_active_tab')
    $(this).addClass('vendor_active_tab')
  });
  $(document).on('click','.vendor_tab_orders', {} ,function(e){
    $('.vendor_main').load('orders')
  });
  $(document).on('click','.vendor_tab_products', {} ,function(e){
    $('.vendor_main').load('products')
  });
  $(document).on('click','.vendor_tab_analytics', {} ,function(e){
    $('.vendor_main').load('orders')
  });
  $(document).on('click','.vendor_tab_account', {} ,function(e){
    $('.vendor_main').load('profile')
  });
  $(document).on('focusout','.vendor_info_input', {} ,function(e){
    $('.loading_area').removeClass('hidden');
    value = ''
    input = $(this).data('action')
    if(input == 'address'){
       $(".vendor_address").each(function(index) {
        value = value + $(this).val() + " "
      });
    } else {
      value = $(this).val()
    }
    req = `/vendor/profile_change?value=${value}&input=${input}`
    $.post(req,function(){
      $('.loading_area').addClass('hidden');
    })
  });
}
window.vendor_product_pagination = function(){
  $(document).ready(function(){
    $('a.page-link').click(function(e){
      e.preventDefault()
      req = 'products?page=' + $(this)[0].href.slice(-1)
      $('.vendor_main').load(req)
    });
    $("#vendor_search").on("change paste keyup", function() {
      req = `search?sku=${$(this).val()}&page=${$(this).data('page')}`
       $('.dynamic_vendor_products_list').load(req)
    });
    $(document).on('click', '.vendor_lock', function(){
      $(this).addClass('hidden');
      $(this).next().removeClass('hidden');
      $(this).closest('li').attr('data-locked', 'false')
      $(this).closest('li').find('.vendor_product_details').prop('disabled', false)
      $(this).closest('li').find('.btn-vendor-save').removeClass('hidden')
    });
    $('.btn-vendor-save').on('click',function(){
      $(this).closest('li').find('.vendor_unlock').addClass('hidden')
      $(this).closest('li').find('.vendor_lock').removeClass('hidden')
      $(this).closest('li').find('.vendor_product_details').prop('disabled', true)
      $(this).addClass('hidden')
    });
  })
}

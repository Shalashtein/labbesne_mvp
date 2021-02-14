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
  $(document).on('click','.vendor_tab_account', {} ,function(e){
    $('.vendor_main').load('profile')
  });
}

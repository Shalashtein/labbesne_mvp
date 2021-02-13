window.vendor = function(){
  $(document).on('click','.vendor_mark_ready', {} ,function(e){
    order = $(this).data('o')
    vendor = $(this).data('v')
    req = '/vendor/order_ready?o=' + order

    $.post(req, function(){
      req = `/vendor/slip?o=${order}&v=${vendor}`
      window.open(req)
    })
  });
}

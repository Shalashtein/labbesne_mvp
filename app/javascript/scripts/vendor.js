window.vendor = function(){
  $(document).on('click','.vendor_mark_ready', {} ,function(e){
    order = $(this).data('o')
    req = '/vendor/order_ready?o=' + order
    $.post(req, function(){
      alert('Marked as sent');
    })
  });
}

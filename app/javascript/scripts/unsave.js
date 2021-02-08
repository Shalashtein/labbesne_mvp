window.unsave = function(){
  $(document).on('click','.unsave', {} ,function(e){
    req = '/closet/unsave?i=' + $(this).data('i');
    $('.customer-container-main').load(req);
  });
}
window.closet_cart = function(){
  $(document).on('click','.closet_cart', {} ,function(e){
    req = '/closet/cart?p=' + $(this).data('p');
    $.get(req, function(data){
      window.location.href = "/";
      $(document).ready(function(){
        $('.products-container-cart-toggler').click();
      })
    })
  });
}

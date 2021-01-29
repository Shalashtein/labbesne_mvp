//----------------------- Sidebar Toggler ----------------------
window.sidebarToggler = function(){
  $('.products-container-sidebar-toggler').click(function(){
    $('.products-container-sidebar').toggleClass('sidebar-active')
    $('.products-container-sidebar-toggler').toggleClass('toggler-active')
    product_id = $('#products-swipe-card-stack li:last-child').data('productid')
    $.get( `/expanded/?product=${product_id}`, function(data) {});
  });
  $('.products-section-swiper').click(function(){
    if($('.products-container-sidebar').hasClass("sidebar-active")){
      $('.products-container-sidebar').toggleClass('sidebar-active')
      $('.products-container-sidebar-toggler').toggleClass('toggler-active')
    }
  });
}

window.cartToggler = function(){
  $('.products-container-cart-toggler').click(function(){
    $('.products-container-cart').toggleClass('cart-active')
    $('.products-container-cart-toggler').toggleClass('toggler-active')
  });
  $('.products-section-swiper').click(function(){
    if($('.products-container-cart').hasClass("cart-active")){
      $('.products-container-cart').toggleClass('cart-active')
      $('.products-container-cart-toggler').toggleClass('toggler-active')
    }
  });
}

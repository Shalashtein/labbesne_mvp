//----------------------- Sidebar Toggler ----------------------
window.sidebarToggler = function(){
  $(document).on('click', '.products-container-sidebar-toggler', function(){
    $('.products-container-sidebar').toggleClass("sidebar-active")
    product_id = $('#products-swipe-card-stack li:last-child').data('productid')
    $.get( `/expanded/?product=${product_id}`, function(data) {});
  })

  $('.products-section-swiper').click(function(){
    if($('.products-container-sidebar').hasClass("sidebar-active")){
      $('.products-container-sidebar').toggleClass('sidebar-active')
    }
  });

  $(document).on('click', '.products-container-cart-toggler', function(){
    $('.products-container-cart').toggleClass("cart-active")
    })
  $('.products-section-swiper').click(function(){
    if($('.products-container-cart').hasClass("cart-active")){
      $('.products-container-cart').toggleClass('cart-active')
    }
  });

  $(document).on('click', '.products-container-settings-toggler', function(){
    $('.products-container-settings').toggleClass("sidebar-active")
    })
  $('.products-section-swiper').click(function(){
    if($('.products-container-settings').hasClass("sidebar-active")){
      $('.products-container-settings').toggleClass('sidebar-active')
    }
  });

  $(document).on('click','.hide-sidebar-cart', {} ,function(e){
    $('.products-container-cart').removeClass('cart-active')
  });
  $(document).on('click','.hide-sidebar-info', {} ,function(e){
    $('.products-container-sidebar').removeClass('sidebar-active')
  });
  $(document).on('click','.hide-sidebar-settings', {} ,function(e){
    $('.products-container-settings').removeClass('sidebar-active')
  });
}


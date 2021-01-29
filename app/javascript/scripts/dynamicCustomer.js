window.dynamicCustomer = function(){
  $('.customer-container-sidebar-tab').click(function(){
    var req = $(this).data('href')
    $('.customer-container-main').load(req);
    $('.customer-container-sidebar-tab').removeClass("customer-tab-active");
    $(this).addClass("customer-tab-active");
  });
}

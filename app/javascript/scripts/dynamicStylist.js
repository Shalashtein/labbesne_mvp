window.dynamicStylist = function(){
  $('#styling_outfits_tab').click(function(){
    $('.stylist-container-body').load('/stylist/outfits');
    $('.styling_tab').removeClass("stylist-tab-active");
    $('#styling_outfits_tab').addClass("stylist-tab-active");
  });
  $(document).on('ajax:success','.page-link', {} ,function(e){
    var req = $(this).attr('href') + `&filter=${$('.filter-active').data('type')}`
    $('.outfit-generator-container-products').load(req);
  });
  $(document).on('click','.stylist-filter', {} ,function(e){
    $('.stylist-filter').removeClass('filter-active');
    $(this).addClass('filter-active');
  });
}

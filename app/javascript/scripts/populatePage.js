// -------------------- Product Specs Page Form Submissions
window.populatePage = function(){
  $('#clothing_type_selector_top').click(function(){
    console.log("click");
    $('.type-top-submit').click();
  });
  $('#clothing_type_selector_pants').click(function(){
    $('.type-pants-submit').click();
  });
  $('#clothing_type_selector_shoes').click(function(){
    $('.type-shoes-submit').click();
  });
  $('#clothing_type_selector_accessory').click(function(){
    $('.type-accessory-submit-submit').click();
  });
  $('.btn-product-specs-save').click(function(){
    $('.fine-submit').click();
  });
};

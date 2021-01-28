//----------------------- Product Filters ----------------------
window.productFilter = function(){
  $('#men-toggler').click(function(){
    if($(this).prop('checked')){
      $('li[data-gender="Men"]').removeClass('hidden');
    } else{
      $('li[data-gender="Men"]').addClass('hidden').prependTo($('#products-swipe-card-stack'));;
    };
  });
  $('#women-toggler').click(function(){
    if($(this).prop('checked')){
      $('li[data-gender="Women"]').removeClass('hidden');
    } else{
      $('li[data-gender="Women"]').addClass('hidden').prependTo($('#products-swipe-card-stack'));;
    };
  });
  $('#top-toggler').click(function(){
    genderChecker('top', $(this).prop('checked'));
  });
  $('#pants-toggler').click(function(){
    genderChecker('pants', $(this).prop('checked'));
  });
  $('#shoes-toggler').click(function(){
    genderChecker('shoes', $(this).prop('checked'));
  });
  $('.gender-router-men-image').click(function(){
    if($('#women-toggler').prop('checked')){
      $('#women-toggler').click();
    }
    if(!$('#men-toggler').prop('checked')){
      $('#men-toggler').click();
    }
    $('html, body').animate({
     scrollTop: $("#products-section").offset().top
    }, 20);
    $('#gender-section').hide();
  });
  $('.gender-router-women-image').click(function(){
    if($('#men-toggler').prop('checked')){
      $('#men-toggler').click();
    }
    if(!$('#women-toggler').prop('checked')){
      $('#women-toggler').click();
    }
    $('html, body').animate({
     scrollTop: $("#products-section").offset().top
    }, 20);
    $('#gender-section').hide();
  });
};

var genderChecker = function(type, checked){
  if(checked){
      if($('#men-toggler').prop('checked')){
        $('li[data-type=' + type + ']').filter('[data-gender="Men"]').show()
      }
      if($('#women-toggler').prop('checked')){
        $('li[data-type=' + type + ']').filter('[data-gender="Women"]').show()
      }
  } else {
    $('li[data-type=' + type + ']').hide();
    $('li[data-type=' + type + ']').prependTo($('#out_deck'));
  }
};

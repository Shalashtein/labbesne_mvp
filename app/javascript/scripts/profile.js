// ------------------------ Profile Form
window.profile = function(){
    var myCarousel = document.querySelector('#profile_forms_slider')
    var carousel = new bootstrap.Carousel(myCarousel)
    carousel.pause()
    $('.gender-selector-block').click(function(){
      gender_input = $('.gender_input_slider')
      if($(this).hasClass('gender-selector-men')){
        $('.gender_input_slider>option[value="Female"]').prop('selected', false);
        $('.gender_input_slider>option[value="Male"]').prop('selected', true);
        gender_input.val('Male')
        carousel.next();
      } else {
        $('.gender_input_slider>option[value="Male"]').prop('selected', false);
        $('.gender_input_slider>option[value="Female"]').prop('selected', true);
        gender_input.val('Female')
        carousel.next();
      }
    });
    $('.info_slide_2_inputs').on('change', function(){
      inputs = []
      x = $('.info_slide_2_inputs')
      x.each(function(){
        if(!$(this).val()){
          inputs.push($(this))
        }
      });
      if(inputs.length == 0){
        $(this.form).on('ajax:start', function(data){
          $('#profile_loader_block').toggleClass('profile_loader_block_visible')
          $('.profile_info_submit').css('opacity', '0')
        });
        $(this.form).on('ajax:success', function(data){
          if($('#info_gender').val() == 'Male'){
            $('.body_type_list_women').addClass('body_type_list_hidden')
            $('.body_type_list_men').removeClass('body_type_list_hidden')
          } else {
            $('.body_type_list_men').addClass('body_type_list_hidden')
            $('.body_type_list_women').removeClass('body_type_list_hidden')
          }
          carousel.next()
          $('.profile_info_submit').css('opacity', '0')
        });
        $('.profile_info_submit').css('opacity', '1')
      }
    });

    $('.body_image_group').click(function(){
      $('#body_measurement_body_types_id').val($(this).data('body'));
      carousel.next()
    })

    $('.btn_profile_next').click(function(event){
      carousel.next();
    });
    $('#body_type_indicator').click(function(){
      if($('#info_gender').val() == 'Male'){
        $('.body_type_list_women').addClass('body_type_list_hidden')
        $('.body_type_list_men').removeClass('body_type_list_hidden')
      } else {
        $('.body_type_list_men').addClass('body_type_list_hidden')
        $('.body_type_list_women').removeClass('body_type_list_hidden')
      }
    });
    var check_measurements = function(){
      if($('#body_measurement_height').val() > 80 && $('#body_measurement_weight').val() > 30 && $('#body_measurement_pants_size').val() > 30 && $('#body_measurement_shoe_size').val() > 30){
        $('.btn_profile_next').show();
      } else {
        $('.btn_profile_next').hide();
      }
    }
    $('#body_measurement_height').on('input', function(){
      $(this).prev().text(`Height ( ${$(this).val()} cm)`)
      check_measurements()
    })
    $('#body_measurement_weight').on('input', function(){
      $(this).prev().text(`Weight ( ${$(this).val()} kg)`)
      check_measurements()
    })
    $('#body_measurement_pants_size').on('input', function(){
      $(this).prev().text(`Pants Size (${$(this).val()})`)
      check_measurements()
    })
    $('#body_measurement_shoe_size').on('input', function(){
      $(this).prev().text(`Shoe Size (${$(this).val()})`)
      check_measurements()
    })
    $('.shirt_size_box').click(function(){
      $('.shirt_size_box').removeClass('shirt_size_box_selected')
      $(this).addClass('shirt_size_box_selected')
      $('#body_measurement_shirt_size').val($(this).attr('value'))
    })
    $('.text_choice_list_item').click(function(){
      if($(this).data('lifestyle') == 'activity'){
        $('#lifestyle_activity_levels_id').val($(this).attr('value'))
      } else if($(this).data('lifestyle') == 'social'){
        $('#lifestyle_social_activities_id').val($(this).attr('value'))
      } else{
        $('#lifestyle_outdoor_levels_id').val($(this).attr('value'))
      }
      carousel.next()
    })
    $('.lifestyle_state_check').click(function(){
      if($(this).attr('id') == 'works_check'){
        $('#lifestyle_works').click();
      } else if ($(this).attr('id') == 'studies_check'){
        $('#lifestyle_studies').click();
      }
    });_
};

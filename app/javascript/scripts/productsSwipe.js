//----------------------- Products Swipe UI ----------------------
window.productSwipe = function(){
  $('#loading').addClass("hidden");
  if($('#products-swipe-card-stack li:last-child').data("saved")){
            $('.save_product_button').addClass('save_product_button_saved')
            $('.save_product_button').html('Saved')
  } else {
    $('.save_product_button').removeClass('save_product_button_saved')
    $('.save_product_button').html('Save for later')
  }
  // Prepare the cards in the stack for iteration.
  const pcards = [].slice.call(document.querySelectorAll('#products-swipe-card-stack li'));

  // An instance of the Stack is used to attach event listeners.
  const config = {
    /**
     * Invoked in the event of dragmove.
     * Returns a value between 0 and 1 indicating the completeness of the throw out condition.
     * Ration of the absolute distance from the original card position and element width.
     *
     * @param {number} xOffset Distance from the dragStart.
     * @param {number} yOffset Distance from the dragStart.
     * @param {HTMLElement} element Element.
     * @returns {number}
     */
    throwOutConfidence: (xOffset, yOffset, element) => {
      var x,y;
      if(screen.width > 500){
        x = 1.5;
      } else {
        x = 2.15;
      }
      const xConfidence = Math.min(Math.abs(xOffset) / element.offsetWidth * x, 1);
      const yConfidence = Math.min(Math.abs(yOffset) / element.offsetHeight, 1);

      return Math.max(xConfidence, yConfidence);
    },
    minThrowOutDistance: screen.width/2+200,
    maxThrowOutDistance: screen.width/2+500
  };

  const pstack = Swing.Stack(config);

  var pcurrentCard = "";
  var t0 = 0.0;
  var t1 = 0.0;
  pcards.forEach((targetElement) => {
    // Add card element to the Stack.
    pstack.createCard(targetElement);
  });

  pstack.on('dragstart', (e) =>{
    pcurrentCard = e.target;
    t0 = performance.now();
  });
  pstack.on('dragmove', (e) => {
    // e.target Reference to the element that has been thrown out of the stack.
    // e.throwDirection Direction in which the element has been thrown (Direction.LEFT, Direction.RIGHT).
    var d = e.throwDirection == Direction.LEFT ? 'left' : 'right'
    //console.log('Yo this shit is moving to the ' + d);
    //console.log('Confidence = ' + e.throwOutConfidence)
    var likeIcon = e.target.querySelector(".swipe-card-like");
    var dislikeIcon = e.target.querySelector(".swipe-card-dislike");
    if(d == 'left'){
      likeIcon.classList.add("hidden");
      dislikeIcon.classList.remove("hidden");
      dislikeIcon.style.opacity = e.throwOutConfidence;
    }
    else{
      likeIcon.classList.remove("hidden");
      likeIcon.style.opacity = e.throwOutConfidence;
      dislikeIcon.classList.add("hidden");
    }

  });

  pstack.on('dragend', (e) =>{
    // Add event listener for when a card is thrown out of the stack.
    t1 = performance.now();
    const swipe_duration = t1 - t0
    //if(swipe_duration < 80){
    //  e.throwDirection == Direction.LEFT ? pstack.getCard(e.target).throwOut(-1*screen.width/2,0) : pstack.getCard(e.target).throwOut(screen.width/2,0)
    //}
  });
  pstack.on('throwout', (e) => {
    // e.target Reference to the element that has been thrown out of the stack.
    // e.throwDirection Direction in which the element has been thrown (Direction.LEFT, Direction.RIGHT).
    //e.target.classList.add("hidden");
    if($(e.target).data("queue") == '0'){
      $('#loading').removeClass("hidden");
      var gender = ""
      if($('#men-toggler').prop('checked') && $('#women-toggler').prop('checked')){
        gender = "all"
      } else if ($('#men-toggler').prop('checked')){
        gender = "male"
      } else if ($('#women-toggler').prop('checked')){
        gender = "female"
      } else{
        gender = "all"
      }
      $('.dynamic-deck').load($('.next_deck').attr('href') + `&gender=${gender}`);
    }

    var product_id = $('#products-swipe-card-stack li:last-child').data("productid")
    if(e.throwDirection == Direction.LEFT){
      $.ajax({
        type:'POST',
        url:'/preferenceAdd',
        data: `data[product]=${product_id}&data[action]=0`,
        success:function(){
          e.target.remove();
          if($('#products-swipe-card-stack li:last-child').data("saved")){
            $('.save_product_button').addClass('save_product_button_saved')
            $('.save_product_button').html('Saved')
          } else {
            $('.save_product_button').removeClass('save_product_button_saved')
            $('.save_product_button').html('Save for later')
          }
        }
      });
    } else {
      $.ajax({
        type:'POST',
        url:'/preferenceAdd',
        data: `data[product]=${product_id}&data[action]=1`,
        success:function(){
          e.target.remove();
          if($('#products-swipe-card-stack li:last-child').data("saved")){
            $('.save_product_button').addClass('save_product_button_saved')
            $('.save_product_button').html('Saved')
          } else {
            $('.save_product_button').removeClass('save_product_button_saved')
            $('.save_product_button').html('Save for later')
          }
        }
      });
    }
    //pstack.getCard(e.target).throwIn(0,0);
    //$(e.target).prependTo($('#products-swipe-card-stack'));
    //pstack.getCard(e.target).destroy()
  });

  // Add event listener for when a card is thrown in the stack, including the spring back into place effect.
  pstack.on('throwin', () => {
    pcurrentCard.querySelector(".swipe-card-like").classList.add("hidden");
    pcurrentCard.querySelector(".swipe-card-dislike").classList.add("hidden");
  });
};

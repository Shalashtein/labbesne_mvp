//----------------------- Products Swipe UI ----------------------
window.landingSwipe = function(){
  $(document).on('click', '.save_product_button_main', function(){
    if($(this).hasClass("save_product_button_saved")){
      $(this).removeClass('save_product_button_saved')
      $(this).html('Save for Later')
  } else {
      $(this).addClass('save_product_button_saved')
      $(this).html('Saved')
  }
  })
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
        x = 2.5;
      }
      const xConfidence = Math.min(Math.abs(xOffset) / element.offsetWidth * x, 1);
      const yConfidence = Math.min(Math.abs(yOffset) / element.offsetHeight, 1);

      return Math.max(xConfidence, yConfidence);
    },
    minThrowOutDistance: 1500,
    maxThrowOutDistance: 2500
  };

  const pstack = Swing.Stack(config);

  var pcurrentCard = "";

  pcards.forEach((targetElement) => {
    // Add card element to the Stack.
    pstack.createCard(targetElement);
  });

  pstack.on('dragstart', (e) =>{
    pcurrentCard = e.target;
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
  });
  pstack.on('throwout', (e) => {
    if($(e.target).data("queue") == '0'){
      $('.dynamic-deck').remove();
      $('.onboard').removeClass('hidden')
      $.get('/guestSwiped', function(){
      });
    }
    var product_id = $('#products-swipe-card-stack li:last-child').data("productid")
    e.target.remove();
    $('.save_product_button_main').removeClass('save_product_button_saved')
    $('.save_product_button_main').html('Save for later')
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
window.dynamicShop = function(){
  $(document).ready(function(){
    if(screen.width > 600){
      $('.hero-image').removeClass('hidden');
    }
  });
  $(document).on('click','.save_product_button', {} ,function(e){
      $.fn.toggleText = function(t1, t2){
    if (this.text() == t1) this.text(t2);
    else                   this.text(t1);
    return this;
  };
    $(this).toggleText('Save for later', 'Saved');
    $('.save_product_button').toggleClass('save_product_button_saved');
    $('#products-swipe-card-stack li:last-child').toggleClass('saved_product');
  });
  $('#pre-dummy').click(function(){
    $('.preregistration-submit').click();
    $('#preregistration_text').html("We'll keep you in the loop");
    $('#pre-dummy').remove();
  });
}

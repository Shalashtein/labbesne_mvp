//----------------------- Products Swipe UI ----------------------
window.productSwipe = function(){
  $('#loading').addClass("hidden");
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
    const xConfidence = Math.min(Math.abs(xOffset) / element.offsetWidth*1.5, 1);
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
    e.target.click();
    console.log(e);
  });

    // Add event listener for when a card is thrown out of the stack.
  pstack.on('throwout', (e) => {
    // e.target Reference to the element that has been thrown out of the stack.
    // e.throwDirection Direction in which the element has been thrown (Direction.LEFT, Direction.RIGHT).
    //e.target.classList.add("hidden");
    if($(e.target).data("queue") == '0'){
      $('#loading').removeClass("hidden");
      $('.dynamic-deck').load($('.next_deck').attr('href'));
    }
    var product_id = $('#products-swipe-card-stack li:last-child').data("productid")
    if(e.throwDirection == Direction.LEFT){
      $.ajax({
        type:'POST',
        url:'/preferenceAdd',
        data: `data[product]=${product_id}&data[action]=0`,
        success:function(){
          //I assume you want to do something on controller action execution success?
          console.log("disliked")
        }
      });
    } else {
      $.ajax({
        type:'POST',
        url:'/preferenceAdd',
        data: `data[product]=${product_id}&data[action]=1`,
        success:function(){
          //I assume you want to do something on controller action execution success?
          console.log("liked")
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

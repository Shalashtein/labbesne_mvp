window.profileSwipe = function(){
    // Prepare the cards in the stack for iteration.
  const cards = [].slice.call(document.querySelectorAll('#swipe-card-stack li'));

  // An instance of the Stack is used to attach event listeners.
  const stack = Swing.Stack();
  var currentCard = "";
  cards.forEach((targetElement) => {
    // Add card element to the Stack.
    stack.createCard(targetElement);
  });

  // Add event listener for when a card is thrown out of the stack.
  stack.on('throwout', (event) => {
    // e.target Reference to the element that has been thrown out of the stack.
    // e.throwDirection Direction in which the element has been thrown (Direction.LEFT, Direction.RIGHT).
    event.target.classList.add("hidden");
    console.log('Card has been thrown out of the stack.');
    console.log('Throw direction: ' + (event.throwDirection == Direction.LEFT ? 'left' : 'right'));
    stack.getCard(event.target).destroy()
  });

  stack.on('dragstart', (event) =>{
    currentCard = event.target;
  });
  stack.on('dragmove', (event) => {
    // e.target Reference to the element that has been thrown out of the stack.
    // e.throwDirection Direction in which the element has been thrown (Direction.LEFT, Direction.RIGHT).
    console.log(event.target);
    var d = event.throwDirection == Direction.LEFT ? 'left' : 'right'
    console.log('Yo this shit is moving to the ' + d);
    if(d == 'left'){
      event.target.querySelector(".swipe-card-like").classList.add("hidden");
      event.target.querySelector(".swipe-card-dislike").classList.remove("hidden");
      event.target.querySelector(".swipe-card-dislike").style.opacity = event.throwOutConfidence;
    }
    else{
      event.target.querySelector(".swipe-card-like").classList.remove("hidden");
      event.target.querySelector(".swipe-card-like").style.opacity = event.throwOutConfidence;
      event.target.querySelector(".swipe-card-dislike").classList.add("hidden");
    }

  });

  // Add event listener for when a card is thrown in the stack, including the spring back into place effect.
  stack.on('throwin', () => {
    console.log('Card has snapped back to the stack.');
    currentCard.querySelector(".swipe-card-like").classList.add("hidden");
    currentCard.querySelector(".swipe-card-dislike").classList.add("hidden");
  });
};

// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("@fortawesome/fontawesome-free/js/all")
require("channels")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)


// ----------------------------------------------------
// Note(lewagon): ABOVE IS RAILS DEFAULT CONFIGURATION
// WRITE YOUR OWN JS STARTING FROM HERE 👇
// ----------------------------------------------------

// External imports
import "bootstrap";
const Swing = require("swing");
require("swing");
// Internal imports, e.g:
// import { initSelect2 } from '../components/init_select2';

document.addEventListener('turbolinks:load', () => {
  productSwipe();
  disabledLinks();
  lifestyleCollapse();
  profileSwipe();
  populatePage();
});

//-------------- Form Collapse in Lifestyle -------------
var lifestyleCollapse = function(){
  $('#lifestyle_studies').click(function studyChanged(){
        if($('#lifestyle_studies').is(":checked"))
            $(".lifestyle_study_hours").show();
        else
            $(".lifestyle_study_hours").hide();
 });
$('#lifestyle_works').click(function workChanged(){
        if($('#lifestyle_works').is(":checked")){
          $(".lifestyle_job_types").show();
          $(".lifestyle_work_hours").show();}
        else{
          $(".lifestyle_job_types").hide();
          $(".lifestyle_work_hours").hide();}
 });
};
/*




*/
//----------------------- Profile Swipe UI ----------------------
var profileSwipe = function(){
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
  }
  else{
    event.target.querySelector(".swipe-card-like").classList.remove("hidden");
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
/*




*/
// -------------------- Product Specs Page Form Submissions
var populatePage = function(){
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
/*




*/
// ------------------------ Disabled Links on Profile Router
var disabledLinks = function(){
   $('a[disabled=disabled]').click(function(event){
        event.preventDefault(); // Prevent link from following its href
    });
};
/*




*/
//----------------------- Products Swipe UI ----------------------
var productSwipe = function(){
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
  }
};

const pstack = Swing.Stack(config);
var pcurrentCard = "";
  pcards.forEach((targetElement) => {
    // Add card element to the Stack.
    pstack.createCard(targetElement);
  });

  // Add event listener for when a card is thrown out of the stack.
  pstack.on('throwout', (e) => {
    // e.target Reference to the element that has been thrown out of the stack.
    // e.throwDirection Direction in which the element has been thrown (Direction.LEFT, Direction.RIGHT).
    e.target.classList.add("hidden");
    console.log('Card has been thrown out of the stack.');
    console.log('Throw direction: ' + (e.throwDirection == Direction.LEFT ? 'left' : 'right'));
    pstack.getCard(e.target).destroy()
  });

  pstack.on('dragstart', (e) =>{
    pcurrentCard = e.target;
  });
  pstack.on('dragmove', (e) => {
    // e.target Reference to the element that has been thrown out of the stack.
    // e.throwDirection Direction in which the element has been thrown (Direction.LEFT, Direction.RIGHT).
    console.log(e.target);
    var d = e.throwDirection == Direction.LEFT ? 'left' : 'right'
    console.log('Yo this shit is moving to the ' + d);
    console.log('Confidence = ' + e.throwOutConfidence)
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
    console.log("DRAG ENDED");
    console.log(e);
  });

  // Add event listener for when a card is thrown in the stack, including the spring back into place effect.
  pstack.on('throwin', () => {
    console.log('Card has snapped back to the stack.');
    pcurrentCard.querySelector(".swipe-card-like").classList.add("hidden");
    pcurrentCard.querySelector(".swipe-card-dislike").classList.add("hidden");
  });
};


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
  // Call your functions here, e.g:
  // initSelect2();
  lifestyleCollapse();
  Swipe();
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

//----------------------- Swipe UI ----------------------
var Swipe = function(){
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

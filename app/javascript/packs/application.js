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

// Internal imports, e.g:
// import { initSelect2 } from '../components/init_select2';

document.addEventListener('turbolinks:load', () => {
  // Call your functions here, e.g:
  // initSelect2();
});
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


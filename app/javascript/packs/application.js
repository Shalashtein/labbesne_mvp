// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("@fortawesome/fontawesome-free/js/all")
require("channels")
require("../controllers/index.js")

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%%= image_pack_tag 'rails.png' %>)
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
const bootstrap = window.bootstrap = require('bootstrap');
const FastClick = window.FastClick = require('fastclick');

require("../scripts/lifestyleCollapse.js")
require("../scripts/populatePage.js")
require("../scripts/profile.js")
require("../scripts/productsSwipe.js")
require("../scripts/productFilters.js")
require("../scripts/sidebarTogglers.js")
require("../scripts/dynamicShop.js")
require("../scripts/dynamicCustomer.js")
require("../scripts/dynamicStylist.js")
require("../scripts/unsave.js")
require("../scripts/vendor.js")
require("../scripts/reconfirm.js")

import { initMapbox } from '../plugins/init_mapbox';
import MapboxGeocoder from '@mapbox/mapbox-gl-geocoder';
const Swing = require("swing");
require("swing");
// Internal imports, e.g:
// import { initSelect2 } from '../components/init_select2';

document.addEventListener('turbolinks:load', () => {
  $(function() {
    FastClick.attach(document.body);
  });
  initMapbox();
  productSwipe();
  recommendation_milestone();
  productFilter();
  sidebarToggler();
  lifestyleCollapse()
  dynamicShop();
  dynamicStylist();
  dynamicCustomer();
  profile();
  dynamicCustomer();
  populatePage();
  unsave();
  closet_cart();
  vendor();
  resend_confirmation()
});

import "controllers"

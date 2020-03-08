import 'jquery';
import 'bootstrap';

import Rails from 'rails-ujs';
import Turbolinks from 'turbolinks';

Rails.start();
Turbolinks.start();

import setupSidenav from '../javascript/modules/sideNav';
import setupAutoSubmit from '../javascript/modules/autoSubmit';

$(function() {
  setupSidenav();
  setupAutoSubmit();
});

console.log('yo');

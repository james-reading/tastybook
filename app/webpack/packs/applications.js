import 'jquery';
import 'bootstrap';

import Rails from 'rails-ujs';
import Turbolinks from 'turbolinks';

Rails.start();
Turbolinks.start();

import setupSidenav from '../javascript/modules/sideNav';

$(function() {
  setupSidenav();
});

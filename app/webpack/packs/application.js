import 'jquery';
import 'bootstrap';
import 'cocoon';

import Rails from 'rails-ujs';
import Turbolinks from 'turbolinks';

Rails.start();
Turbolinks.start();

import setupSidenav from '../javascript/modules/side_nav';
import setupAutoSubmit from '../javascript/modules/auto_submit';

$(function() {
  setupSidenav();
  setupAutoSubmit();
});

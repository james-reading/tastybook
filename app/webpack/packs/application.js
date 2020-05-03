import Rails from 'rails-ujs';
import Turbolinks from 'turbolinks';

Rails.start();
Turbolinks.start();

import 'jquery';
import 'cocoon';
import 'trix';
import '@rails/actiontext';

import 'bootstrap/js/src/collapse';
import 'bootstrap/js/src/dropdown';
import 'bootstrap/js/src/tab';
import 'bootstrap/js/src/alert';

import '../javascript/modules/sideNav';
import '../javascript/modules/confirmExitForm';
import '../javascript/modules/turbolinksBeforeCache';

require.context('../images', true);

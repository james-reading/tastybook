import Rails from 'rails-ujs';
import Turbolinks from 'turbolinks';


//TODO: Split into only what we need from bootstrap
import 'bootstrap/dist/js/bootstrap';


// Enable Bootstrap's tooltip
$('[data-toggle="tooltip"]').tooltip();
$(document).on("turbolinks:render turbolinks:load", (event) => {
  $('[data-toggle="tooltip"]').tooltip();
});

$(document).on("turbolinks:before-cache", (event) => {
  $('[data-toggle="tooltip"]').tooltip('dispose');
})

Rails.start();
Turbolinks.start();



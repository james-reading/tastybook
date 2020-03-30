const OPEN_CLASS = 'sidenav-open';

$(document).on('click', '.sidenav-toggle', function() {
  $('body').toggleClass(OPEN_CLASS);
});

$(document).on('turbolinks:before-cache', function() {
  $('body').removeClass(OPEN_CLASS);
});

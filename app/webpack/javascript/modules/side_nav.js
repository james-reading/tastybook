export default function setupSideNav() {
  $(document).on('click', '.sidenav-toggle', function() {
    $('.sidenav').toggleClass('open');
  });

  $(document).on('turbolinks:before-cache', function() {
    $('.sidenav').removeClass('open');
  });
}

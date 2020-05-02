import htmlClasses from '../helpers/htmlClasses';
const OPEN_CLASS = 'sidenav-open';

document.addEventListener('click', () => {
  if (event.target.closest('.hamburger')) {
    htmlClasses.toggle(OPEN_CLASS);
  }
});

document.addEventListener('turbolinks:before-cache', () => {
  htmlClasses.remove(OPEN_CLASS);
});

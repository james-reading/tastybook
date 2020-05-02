const SELECTOR = '.js-turbolinks-empty-before-cache';

document.addEventListener('turbolinks:before-cache', () => {
  document.querySelectorAll(SELECTOR).forEach(el => (el.innerHTML = ''));
});

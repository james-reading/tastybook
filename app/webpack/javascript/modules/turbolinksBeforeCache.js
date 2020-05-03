const EMPTY_SELECTOR = '.js-turbolinks-empty-before-cache';
const COLLAPSE_SELECTOR = '.js-turbolinks-collapse-before-cache';

document.addEventListener('turbolinks:before-cache', () => {
  document.querySelectorAll(EMPTY_SELECTOR).forEach(el => (el.innerHTML = ''));
  $(COLLAPSE_SELECTOR).collapse('hide');
});

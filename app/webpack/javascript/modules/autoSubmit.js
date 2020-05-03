import Rails from 'rails-ujs';

document.addEventListener('change', () => {
  if (event.target.matches('.js-auto-submit')) {
    const form = event.target.closest('form');

    Rails.fire(form, 'submit');
  }
});

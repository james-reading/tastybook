import Rails from 'rails-ujs';

document.addEventListener('change', ({ target }) => {
  if (target.matches('.js-auto-submit-on-change')) {
    const form = target.closest('form');

    if (form.dataset.remote) {
      Rails.fire(form, 'submit');
    } else {
      form.submit();
    }
  }
});

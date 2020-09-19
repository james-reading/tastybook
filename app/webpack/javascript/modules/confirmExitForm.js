const FORM_CLASS = 'js-confirm-exit';
const WARNING_TEXT =
  'Your changes have not been saved, are you sure you wish to leave?';
let confirmExitForm = false;

document.addEventListener('turbolinks:before-visit', event => {
  if (confirmExitForm && document.querySelector('.' + FORM_CLASS)) {
    if (confirm(WARNING_TEXT)) {
      confirmExitForm = false;
    } else {
      event.preventDefault();
    }
  }
});

document.addEventListener('turbolinks:visit', () => {
  confirmExitForm = false;
});

function setConfirmExitForm() {
  const form = event.target.closest('form');

  if (form.classList.contains(FORM_CLASS)) {
    confirmExitForm = true;
  }
}

document.addEventListener('change', setConfirmExitForm);
document.addEventListener('cocoon:after-insert', setConfirmExitForm);
document.addEventListener('cocoon:after-remove', setConfirmExitForm);

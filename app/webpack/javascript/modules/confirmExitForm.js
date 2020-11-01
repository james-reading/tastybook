const FORM_CLASS = 'js-confirm-exit';
const WARNING_TEXT =
  'Your changes have not been saved, are you sure you wish to leave?';
let confirmExitForm = false;

document.addEventListener('turbolinks:before-visit', event => {
  window.ev = event;
  if (confirmExitForm && document.querySelector('.' + FORM_CLASS)) {
    if (confirm(WARNING_TEXT)) {
      confirmExitForm = false;
    } else {
      event.preventDefault();
    }
  } else {
    confirmExitForm = false;
  }
});

document.addEventListener('turbolinks:visit', () => {
  confirmExitForm = false;
});

document.addEventListener('ajax:send', () => {
  // When we submit the form
  confirmExitForm = false;
});

function setConfirmExitForm() {
  const form = event.target.closest('form');

  if (form && form.classList.contains(FORM_CLASS)) {
    confirmExitForm = true;
  }
}

document.addEventListener('change', setConfirmExitForm);
document.addEventListener('cocoon:after-insert', setConfirmExitForm);
document.addEventListener('cocoon:after-remove', setConfirmExitForm);

const warningText =
  'Your changes have not been saved, are you sure you wish to leave?';
let confirmExitForm = false;

document.addEventListener('turbolinks:before-visit', event => {
  if (confirmExitForm) {
    if (confirm(warningText)) {
      confirmExitForm = false;
    } else {
      event.preventDefault();
    }
  }
});

function setConfirmExitForm() {
  const form = event.target.closest('form');

  if (form.classList.contains('js-confirm-exit')) {
    confirmExitForm = true;
  }
}

document.addEventListener('change', setConfirmExitForm);
document.addEventListener('cocoon:after-insert', setConfirmExitForm);
document.addEventListener('cocoon:after-remove', setConfirmExitForm);

const addError = function addError(input, message) {
  clearError(input);

  const errorSpan = document.createElement('span');

  errorSpan.textContent = message;
  errorSpan.classList.add('invalid-feedback');
  input.classList.add('is-invalid');
  input.closest('.form-group')?.classList?.add('form-group-invalid');

  if (input.parentElement.classList.contains('position-relative')) {
    input.parentElement.insertAdjacentElement('afterend', errorSpan);
  } else {
    input.insertAdjacentElement('afterend', errorSpan);
  }
};

const clearError = function clearError(input) {
  input
    .closest('.form-group')
    .querySelector('.invalid-feedback')
    ?.remove();
  input
    .closest('.form-group')
    .querySelector('.is-invalid')
    ?.classList.remove('is-invalid');
  input
    .closest('.form-group')
    ?.classList.remove('form-group-invalid');
};

const formHelper = {
  addError: addError,
  clearError: clearError
};

export default formHelper;

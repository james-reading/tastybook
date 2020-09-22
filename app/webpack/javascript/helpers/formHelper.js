const addError = function addError(input, message) {
  clearError(input);

  const errorSpan = document.createElement('span');

  errorSpan.textContent = message;
  errorSpan.classList.add('invalid-feedback');
  input.classList.add('is-invalid');
  input.insertAdjacentElement('afterend', errorSpan);
};

const clearError = function clearError(input) {
  input
    .parentNode
    .querySelector('.invalid-feedback')
    ?.remove();
  input
    .parentNode
    .querySelector('.is-invalid')
    ?.classList.remove('is-invalid');
};

const formHelper = {
  addError: addError,
  clearError: clearError
};

export default formHelper;

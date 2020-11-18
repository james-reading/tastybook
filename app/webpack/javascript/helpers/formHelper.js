const renderErrors = function renderErrors(form, model_name, errors) {
  for (const [field, messages] of Object.entries(errors)) {
    const input = form.querySelector(`[name="${model_name}[${field}]"]`);

    addError(input, messages.join(', '));
  }

  form.querySelector('.is-invalid').focus();
};

const clearErrors = function renderErrors(form) {
  form.querySelectorAll('.invalid-feedback').forEach(element => {
    element.remove();
  });

  form.querySelectorAll('.is-invalid').forEach(element => {
    element.classList.remove('is-invalid');
  });

  form.querySelectorAll('.form-group-invalid').forEach(element => {
    element.classList.remove('form-group-invalid');
  });
};

const addError = function addError(input, message) {
  const inputWrapper = input.closest('.form-group');

  const errorSpan =
    inputWrapper.querySelector('.invalid-feedback') ||
    document.createElement('span');

  errorSpan.textContent = message;
  errorSpan.classList.add('invalid-feedback');

  input.classList.add('is-invalid');
  inputWrapper.classList.add('form-group-invalid');

  if (input.parentElement.classList.contains('position-relative')) {
    // This is for password fields (with the toggle button)
    input.parentElement.insertAdjacentElement('afterend', errorSpan);
  } else {
    input.insertAdjacentElement('afterend', errorSpan);
  }
};

const clearError = function clearError(input) {
  const inputWrapper = input.closest('.form-group');

  inputWrapper.querySelector('.invalid-feedback')?.remove();

  inputWrapper.querySelector('.is-invalid')?.classList.remove('is-invalid');

  inputWrapper.classList.remove('form-group-invalid');
};

const formHelper = {
  renderErrors: renderErrors,
  clearErrors: clearErrors,
  addError: addError,
  clearError: clearError
};

export default formHelper;

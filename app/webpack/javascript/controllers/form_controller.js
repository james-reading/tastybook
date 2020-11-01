import { Controller } from 'stimulus';
import Rails from 'rails-ujs';
import formHelper from '../helpers/formHelper';

const validations = [
  'badInput',
  'customError',
  'patternMismatch',
  'rangeOverflow',
  'rangeUnderflow',
  'stepMismatch',
  'tooLong',
  'tooShort',
  'typeMismatch',
  'valid',
  'valueMissing'
];

export default class extends Controller {
  connect() {
    console.log('Connected to form-controller');

    this.element.addEventListener('blur', this.onBlur, true);
    this.element.addEventListener('input', this.onInput, true);
    this.element.addEventListener('ajax:beforeSend', this.onSubmit);
  }

  disconnect() {
    this.element.removeEventListener('blur', this.onBlur);
    this.element.removeEventListener('input', this.onInput);
    this.element.removeEventListener('ajax:beforeSend', this.onSubmit);
  }

  onBlur = event => {
    this.validateField(event.target);
  };

  onInput = event => {
    if (event.target.classList.contains('is-invalid')) {
      this.reValidateField(event.target);
    }
  };

  onSubmit = event => {
    if (!this.validateForm()) {
      event.preventDefault();
      this.firstInvalidField.focus();
    }
  };

  validateForm() {
    let isValid = true;

    this.formFields.forEach(field => {
      if (
        this.shouldValidateField(field) &&
        !this.validateField(field, false)
      ) {
        isValid = false;
      }
    });

    return isValid;
  }

  validateField(field, performServerValidations = true) {
    if (!this.shouldValidateField(field)) {
      return true;
    }

    let isValid = field.checkValidity();

    if (isValid) {
      if (performServerValidations && field.dataset.validationUrl) {
        this.validateOnServer(field);
      } else {
        formHelper.clearError(field);
      }
    } else {
      formHelper.addError(field, field.validationMessage);

      field.data = { failedValidations: this.failedValidations(field) };
    }

    return isValid;
  }

  reValidateField(field) {
    // For validating a field that is already displaying an error
    // We clear the error if the previous failed validation is fixed, even if
    // other validations fail.

    const validity = field.validity;
    const failedValidations = field.data?.failedValidations || [];

    let isValid = true;

    failedValidations.forEach(failedValidation => {
      if (validity[failedValidation]) {
        isValid = false;
      }
    });

    if (isValid) {
      if (field.dataset.validationUrl) {
        this.validateOnServer(field);
      } else {
        formHelper.clearError(field);
      }
    }
  }

  shouldValidateField(field) {
    return (
      !field.disabled &&
      !['file', 'reset', 'submit', 'button', 'hidden'].includes(field.type) &&
      !['A'].includes(field.tagName)
    );
  }

  validateOnServer(field) {
    Rails.ajax({
      url: field.dataset.validationUrl + '?value=' + field.value,
      type: 'get',
      dataType: 'json',
      success: () => {
        formHelper.clearError(field);
      },
      error: data => {
        formHelper.addError(field, data.error);
      }
    });
  }

  get formFields() {
    return Array.from(this.element.elements);
  }

  get firstInvalidField() {
    return this.formFields.find(field => !field.checkValidity());
  }

  failedValidations(field) {
    const validity = field.validity;
    const failedValidations = [];

    validations.forEach(validation => {
      if (validity[validation]) {
        failedValidations.push(validation);
      }
    });

    return failedValidations;
  }

  // disableSubmitIfEmpty() {
  //   if (event.currentTarget.value) {
  //     this.submitTarget.removeAttribute('disabled');
  //   } else {
  //     this.submitTarget.setAttribute('disabled', true);
  //   }
  // }
}

import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ['submit'];

  disableSubmitIfEmpty() {
    if (event.currentTarget.value) {
      this.submitTarget.removeAttribute('disabled');
    } else {
      this.submitTarget.setAttribute('disabled', true);
    }
  }
}

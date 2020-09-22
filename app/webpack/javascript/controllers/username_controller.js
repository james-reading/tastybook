import Rails from 'rails-ujs';
import { Controller } from 'stimulus';
import formHelper from '../helpers/formHelper';

export default class extends Controller {
  static targets = ['input'];

  check() {
    Rails.ajax({
      url: this.data.get('url') + '?username=' + this.inputTarget.value,
      type: 'get',
      dataType: 'json',
      success: () => {
        formHelper.clearError(this.inputTarget)
      },
      error: (data) => {
        formHelper.addError(this.inputTarget, data.error)
      }
    });
  }
}

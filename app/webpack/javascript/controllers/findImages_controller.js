import { Controller } from 'stimulus';
import Rails from 'rails-ujs';

export default class extends Controller {
  static targets = ['input', 'error'];

  get() {
    const button = event.currentTarget;
    const sourceUrl = this.inputTarget.value;

    document.getElementById('find-images-modal')?.remove();

    this.errorTarget.innerHTML = '';
    button.classList.add('tb-disable-with-spinner');
    button.disabled = true;

    Rails.ajax({
      url: this.data.get('path') + `?source_url=${sourceUrl}`,
      type: 'GET',
      dataType: 'json',
      success: data => {
        document.querySelector('body').insertAdjacentHTML('beforeend', data.modal_html);

        $('#find-images-modal').modal('show');
      },
      error: data => {
        this.errorTarget.innerHTML = data.error || 'There was an error'
      },
      complete: () => {
        button.classList.remove('tb-disable-with-spinner');
        button.disabled = false;
      }
    });
  }

  clearError() {
    this.errorTarget.innerHTML = '';
  }
}

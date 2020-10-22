import { Controller } from 'stimulus';
import Rails from 'rails-ujs';

export default class extends Controller {
  static targets = ['sourceInput', 'imageUrlInput', 'grabButton', 'imageReceiver', 'errorSpan'];

  initialize() {
    console.log('Connected to find-images-controller');
  }

  run() {
    this.errorSpanTarget.innerHTML = '';
    this.grabButtonTarget.classList.add('tb-disable-with-spinner');
    this.grabButtonTarget.disabled = true;

    Rails.ajax({
      url: this.data.get('path') + `?source_url=${this.sourceInputTarget.value}`,
      type: 'GET',
      dataType: 'json',
      success: data => {
        document.body.insertAdjacentHTML('beforeend', data.modal_html);

        $('#find-images-modal').modal('show');
      },
      error: data => {
        this.errorSpanTarget.innerHTML = data.error || 'There was an error';
      },
      complete: () => {
        this.grabButtonTarget.classList.remove('tb-disable-with-spinner');
        this.grabButtonTarget.disabled = false;
      }
    });
  }

  clearError() {
    this.errorSpanTarget.innerHTML = '';
  }

  clearImage() {
    this.imageUrlInputTarget.value = '';
    this.grabButtonTarget.style.display = 'block';
    this.imageReceiverTarget.innerHTML = '';
  }

  setImage(imageUrl) {
    this.grabButtonTarget.style.display = 'none';
    this.imageUrlInputTarget.value = imageUrl;

    const img = document.createElement('img');
    img.classList.add('img-fluid', 'rounded', 'mt-3', 'd-block');
    img.src = imageUrl;

    this.imageReceiverTarget.appendChild(img);

     const modal = document.getElementById('find-images-modal');
     $(modal).modal('hide');
     modal.remove();
  }
}

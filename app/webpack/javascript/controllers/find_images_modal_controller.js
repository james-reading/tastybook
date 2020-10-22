import { Controller } from 'stimulus';
import Rails from 'rails-ujs';

export default class extends Controller {
  static targets = ['imageInput'];

  initialize() {
    console.log('Connected to find-images-modal-controller');
  }

  selectImage() {
    const selection = this.imageInputTargets.find(input => input.checked == true)

    if (selection) {
      let findImagesController = this.application.getControllerForElementAndIdentifier(
          document.getElementById('find-images-controller'),
          'find-images'
      );

      findImagesController.setImage(selection.value);

      // const button = document.getElementById('grab-image-btn');
      // const input = document.getElementById('grab-image-url');
      //
      // input.value = selection.value;
      // button.style.display = 'none';
      //
      // const img = document.createElement('img');
      // img.classList.add('img-fluid', 'rounded', 'mt-3', 'd-block')
      // img.src = selection.value;
      //
      // document
      //   .querySelector('.js-find-images-receiver')
      //   .appendChild(img)
      //
      // $('#find-images-modal').modal('hide');
    }
  }
}

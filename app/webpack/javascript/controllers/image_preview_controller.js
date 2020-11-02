import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ['input', 'output', 'img'];

  readURL() {
    const input = this.inputTarget;
    const output = this.outputTarget;

    if (input.files && input.files[0]) {
      var reader = new FileReader();

      reader.onload = () => {
        this.imgTarget.style.display = 'none';

        output.style.backgroundImage = `url("${reader.result}")`;
      };

      reader.readAsDataURL(input.files[0]);
    }
  }
}

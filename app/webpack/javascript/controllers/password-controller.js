import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ['input', 'toggle'];

  connect() {
    console.log('Connected to password-controller')

    this.toggleTarget.style.display = 'block'
  }

  toggle() {
    this.inputTarget.focus();

    if (this.inputTarget.type === 'password') {
      this.inputTarget.type = 'text';
    } else {
      this.inputTarget.type = 'password';
    }
  }

}

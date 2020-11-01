import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ['button'];

  connect() {
    console.log('Connected to auto-disable-controller');
  }

  toggle() {
    this.buttonTarget.disabled = !event.currentTarget.value;
  }
}

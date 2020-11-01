import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ['flash'];

  connect() {
    console.log('Connected to flash-controller');

    this.element.addEventListener('transitionend', () => this.element.remove());

    this.element.style.opacity = '1';
    this.element.style.transition = 'opacity 1s';
    setTimeout(() => {
      this.element.style.opacity = '0';
    }, 2000);
  }
}

import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ['source', 'button'];

  connect() {
    if (document.queryCommandSupported('copy')) {
      this.buttonTarget.classList.remove('d-none');
    }
  }

  copy() {
    this.sourceTarget.select();
    document.execCommand('copy');
    this.sourceTarget.blur();

    this.buttonTarget.innerText = 'Copied!';

    setTimeout(() => {
      this.buttonTarget.innerText = 'Copy';
    }, 1000);
  }
}

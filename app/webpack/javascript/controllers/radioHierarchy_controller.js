import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ['radio'];

  set() {
    const hierarchy = event.currentTarget.dataset.hierarchy;
    const checked = event.currentTarget.checked;

    if (checked) {
      this.radioTargets.forEach(radio => {
        if (radio.dataset.hierarchy < hierarchy) {
          radio.checked = true;
        }
      });
    } else {
      this.radioTargets.forEach(radio => {
        if (radio.dataset.hierarchy > hierarchy) {
          radio.checked = false;
        }
      });
    }
  }
}

import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ['input'];

  connect() {
    const clearEl = document.createElement('button')
    clearEl.classList.add('tb-search--clear')
    clearEl.setAttribute('type', 'button')
    clearEl.style.display = 'none'
    this.inputTarget.parentNode.insertBefore(clearEl, this.inputTarget.nextSibling);

    this.inputTarget.addEventListener('input', () => {
      if (this.inputTarget.value) {
        clearEl.style.display = 'block'
      } else {
        clearEl.style.display = 'none'
      }
    })

    clearEl.addEventListener('click', () => {
      this.inputTarget.value = '';
      this.inputTarget.focus();
      clearEl.style.display = 'none'
    })

    clearEl.addEventListener('mousedown', event => {
      event.preventDefault();
    })
  }
}

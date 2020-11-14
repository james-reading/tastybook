import Rails from 'rails-ujs';
import { Controller } from 'stimulus';

const LIKED_CLASS = 'tb-like-btn--liked';

export default class extends Controller {
  toggle(event) {
    event.preventDefault();
    const target = event.currentTarget;

    target.classList.toggle(LIKED_CLASS);
    target.querySelector('.sr-only').textContent = srText(target);

    Rails.ajax({
      url: target.getAttribute('data-url'),
      type: httpMethod(target)
    });
  }
}

function httpMethod(element) {
  return element.classList.contains(LIKED_CLASS) ? 'POST' : 'DELETE';
}

function srText(element) {
  return element.classList.contains(LIKED_CLASS)
    ? 'Unlike recipe'
    : 'Like recipe';
}

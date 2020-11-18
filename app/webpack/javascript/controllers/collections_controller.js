import { Controller } from 'stimulus';
import Rails from 'rails-ujs';
import formHelper from '../helpers/formHelper';

export default class extends Controller {
  static targets = [
    'selectCollection',
    'newCollection',
    'nameInput',
    'collectionList',
    'cancelNew'
  ];

  initialize() {
    console.log('Connected to collections controller');
  }

  new() {
    const form = this.newCollectionTarget.querySelector('form');
    formHelper.clearErrors(form);
    form.reset();

    this.cancelNewTarget.style.display = 'block';
    this.selectCollectionTarget.style.display = 'none';
    this.newCollectionTarget.style.display = 'block';

    this.nameInputTarget.focus();
  }

  cancelNew() {
    this.newCollectionTarget.style.display = 'none';
    this.selectCollectionTarget.style.display = 'block';
  }

  createSuccess(event) {
    const data = event.detail[0];

    this.collectionListTarget.insertAdjacentHTML(
      'afterbegin',
      data.collection_html
    );

    this.newCollectionTarget.style.display = 'none';
    this.selectCollectionTarget.style.display = 'block';
  }

  createError(event) {
    const data = event.detail[0];
    const form = this.newCollectionTarget.querySelector('form');

    formHelper.renderErrors(form, 'collection', data.errors);
  }

  toggle(event) {
    const button = event.currentTarget;
    const savedClass = button.dataset.savedClass;
    const isSaved = button.classList.contains(savedClass);

    button.classList.toggle(savedClass);

    Rails.ajax({
      url: event.currentTarget.dataset.url,
      type: isSaved ? 'DELETE' : 'PUT',
      dataType: 'json'
    });
  }
}

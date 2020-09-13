import Sortable from 'sortablejs';

document.addEventListener('turbolinks:load', () => {
  const sortableList = document.getElementById('steps');

  sortableList &&
    new Sortable(sortableList, {
      animation: 150,
      handle: '.js-sortable-handle',
      draggable: '.nested-fields',
      onEnd: () => {
        document
          .querySelectorAll('.js-step-position-input')
          .forEach((item, i) => {
            item.value = i + 1;
          });
      }
    });
});

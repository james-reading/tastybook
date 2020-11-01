import Sortable from 'sortablejs';

document.addEventListener('turbolinks:load', () => {
  const sortableFields = document.querySelectorAll('.js-sortable-fields');

  sortableFields.forEach(fields => {
    new Sortable(fields, {
      handle: '.js-sortable-handle',
      draggable: '.nested-fields',
      onEnd: () => {
        fields.querySelectorAll('.js-position-input').forEach((item, i) => {
          item.value = i + 1;
        });
      },
      onChange: event => {
        const input = event.item.querySelector(
          'input.form-control, textarea.form-control'
        );

        input.classList.add('tb-pulse');
      }
    });
  });
});

$(document).on(
  'cocoon:after-insert',
  (_event, insertedItem, _originalEvent) => {
    insertedItem.find('.js-cocoon-focus').focus();
  }
);

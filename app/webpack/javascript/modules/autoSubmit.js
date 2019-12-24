export default function setupAutoSubmit() {
  $('.js-form-autosubmit').on('input', function() {
    this.dispatchEvent(new Event('submit', { bubbles: true }));
  });
}

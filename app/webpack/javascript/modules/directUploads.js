document.addEventListener('direct-upload:initialize', () => {
  const recipeElement = document.querySelector('.js-recipe-card');

  recipeElement.insertAdjacentHTML(
    'beforebegin',
    `
    <div class="progress mb-3">
      <div class="js-upload-progress progress-bar progress-bar-striped" role="progressbar" style="width:10%" aria-valuenow="10" aria-valuemin="0" aria-valuemax="100"></div>
    </div>
  `
  );
});

document.addEventListener('direct-upload:progress', event => {
  const progress = event.detail.progress;

  const progressElement = document.querySelector('.js-upload-progress');
  progressElement.style.width = `${progress}%`;
});

document.addEventListener('direct-upload:initialize', () => {
  const recipeElement = document.querySelector('.js-recipe-card');

  if (recipeElement) {
    recipeElement.insertAdjacentHTML(
      'beforebegin',
      `
      <div class="progress mb-3">
        <div class="js-upload-progress progress-bar progress-bar-striped" role="progressbar" style="width:5%" aria-valuenow="10" aria-valuemin="0" aria-valuemax="100"></div>
      </div>
    `
    );

    return;
  }

  const profileElement = document.querySelector('.js-profile-card');

  if (profileElement) {
    profileElement.insertAdjacentHTML(
      'afterend',
      `
      <div class="progress mb-3">
        <div class="js-upload-progress progress-bar progress-bar-striped" role="progressbar" style="width:5%" aria-valuenow="10" aria-valuemin="0" aria-valuemax="100"></div>
      </div>
    `
    );

    return;
  }
});

document.addEventListener('direct-upload:progress', event => {
  const progressElement = document.querySelector('.js-upload-progress');

  if (progressElement) {
    const progress = event.detail.progress;

    progressElement.style.width = `${progress}%`;
  }
});

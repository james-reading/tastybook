import LazyLoad from 'vanilla-lazyload';

let lazyLoad;

document.addEventListener('turbolinks:load', () => {
  lazyLoad = new LazyLoad();
});

document.addEventListener('lazyload', () => {
  lazyLoad.update();
});

document.addEventListener('turbolinks:before-render', event => {
  const isPreview = document.documentElement.hasAttribute(
    'data-turbolinks-preview'
  );

  if (!isPreview) {
    const lazyImages = event.data.newBody.querySelectorAll('.lazy[data-src]');

    lazyImages.forEach(img => {
      const src = img.dataset.src;
      const cachedImage = document.querySelector(`.lazy[src="${src}"]`);

      if (cachedImage && cachedImage.complete) {
        img.setAttribute('src', src);
        img.removeAttribute('data-src');
      }
    });
  }
});

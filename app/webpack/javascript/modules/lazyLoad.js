import LazyLoad from 'vanilla-lazyload';

function lazyload() {
  new LazyLoad();
}

document.addEventListener('turbolinks:load', lazyload);
document.addEventListener('lazyload', lazyload);

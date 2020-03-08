import debounce from 'lodash/debounce';

const THRESHOLD = 500;
const $window = $(window);
const $document = $(document);
let currentPage = 1;
let baseEndpoint;

function setupInfiniteScroll() {
  const $paginationElem = $('.js-infinite-scroll');

  if ($paginationElem.length) {
    const paginationUrl = $paginationElem.attr('data-pagination-endpoint');
    const pagesAmount = $paginationElem.attr('data-pagination-pages');

    /* validate if the pagination URL has query params */
    if (paginationUrl.indexOf('?') != -1) {
      baseEndpoint = paginationUrl + '&page=';
    } else {
      baseEndpoint = paginationUrl + '?page=';
    }

    /* initialize pagination */
    $paginationElem.hide();
    let isPaginating = false;

    /* listen to scrolling */
    $window.on(
      'scroll.infinite-scroll',
      debounce(function() {
        if (
          !isPaginating &&
          currentPage < pagesAmount &&
          $window.scrollTop() >
            $document.height() - $window.height() - THRESHOLD
        ) {
          isPaginating = true;
          currentPage++;
          $paginationElem.show();
          $.ajax({
            url: baseEndpoint + currentPage
          }).done(function(result) {
            $('.js-updateable-recipes').append(result);
            isPaginating = false;
          });
        }
        if (currentPage >= pagesAmount) {
          $paginationElem.hide();
        }
      }, 100)
    );
  }
}

function teardownInfiniteScroll() {}

$(document).on('turbolinks:load', setupInfiniteScroll);
$(document).on('turbolinks:before-cache', teardownInfiniteScroll);

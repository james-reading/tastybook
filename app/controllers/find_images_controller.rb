class FindImagesController < ApplicationController

  def index
    image_urls = MetaInspector.new(params[:source_url]).images.to_a

    if image_urls.empty?
      render json: { error: 'No images found' }, status: 422
    else
      render json: {
        modal_html: render_to_string(
          partial: 'find_images/modal',
          locals: {
            image_urls: image_urls
          },
          formats: [:html]
        )
      }
    end
  rescue MetaInspector::TimeoutError, MetaInspector::RequestError, MetaInspector::NonHtmlError
    render json: { error: 'Unable to access URL' }, status: 422
  rescue MetaInspector::ParserError
    render json: { error: 'Invalid URL' }, status: 422
  end
end

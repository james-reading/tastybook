class ErrorsController < ApplicationController

  def internal_error
    render 'errors/internal_error', status: 500
  end

  def not_found
    render 'errors/not_found', status: 404
  end
end

class ApplicationController < ActionController::Base
  include Pundit

  def app_name
    'Recipes'
  end
  helper_method :app_name
end

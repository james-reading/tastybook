class Admin::ApplicationController < ApplicationController
  before_action :authenticate_user!, :authorize_admin!

  layout 'admin'

  private

  def authorize_admin!
    unless current_user.admin?
      redirect_to root_path
    end
  end
end

class RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters

  private

  def sign_up(resource_name, resource)
    cookies[:friendship_uuid] && accept_friend_request(resource)

    super
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end
end

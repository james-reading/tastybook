class SessionsController < Devise::SessionsController

  private

  def sign_in(resource_name, resource)
    cookies[:friendship_uuid] && accept_friend_request(resource)

    super
  end
end

class ApplicationController < ActionController::Base
  include Pundit

  before_action :http_basic_authenticate, if: -> { ENV['HTTP_AUTH_PASSWORD'].present? }

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def http_basic_authenticate
    authenticate_or_request_with_http_basic do |name, password|
      name == 'tastybook' && password == ENV['HTTP_AUTH_PASSWORD']
    end
  end

  def user_not_authorized(exception)
    redirect_back fallback_location: root_path, alert: user_not_authorized_message
  end

  def user_not_authorized_message
    'You are not allowed to do that'
  end

  def accept_friend_request(user)
    friendship = Friendship.find_by_uuid cookies.delete(:friendship_uuid)

    if friendship && !friendship.accepted?
      if friendship.user == resource
        flash[:alert] = 'You cannot accept your own friend request!'

        return
      end

      friendship.friend = resource

      if friendship.accept!
        flash[:success] = "Your are now friends with #{friendship.user.username}"
      end
    end
  rescue ActiveRecord::RecordNotUnique
    flash[:alert] = "Your are already friends with #{friendship.user.username}"
  end
end

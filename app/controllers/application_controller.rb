class ApplicationController < ActionController::Base
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized(exception)
    redirect_back fallback_location: root_path, alert: user_not_authorized_message
  end

  def user_not_authorized_message
    'You are not allowed to do that'
  end

  def accept_friend_request(user)
    friendship = Friendship.find_by_uuid cookies.delete(:friendship_uuid)

    if friendship && !friendship.accepted?
      friendship.friend = resource
      friendship.accept!

      flash[:success] = "Your are now friends with #{friendship.user.username}"
    end
  end
end

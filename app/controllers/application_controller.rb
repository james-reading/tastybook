class ApplicationController < ActionController::Base
  include Pundit

  private

  def accept_friend_request(user)
    friendship = Friendship.find_by_uuid cookies.delete(:friendship_uuid)

    if friendship && !friendship.accepted?
      friendship.friend = resource
      friendship.accept!

      flash[:success] = "Your are now friends with #{friendship.user.username}"
    end
  end
end

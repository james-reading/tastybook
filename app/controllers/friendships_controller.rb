class FriendshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_friendship, only: [:destroy, :accept]

  def index
    @friendships = current_user.friendships.includes(:friend)
    @suggestions = current_user.friend_suggestions
    @friend_requests = current_user.friend_requests
  end

  def create
    @friend_request_form = FriendRequestForm.new(
      friend_request_params.merge(
        user: current_user
      )
    )

    if @friend_request_form.submit

      if @friend_request_form.friendship.accepted?
        flash[:success] = "You are now friends with #{@friend_request_form.friend.username}"
      else
        flash[:success] = t('flashes.friendship.create.success', username: @friend_request_form.friend.username)
      end


    elsif @friend_request_form.friend
      flash[:alert] = t('flashes.friendship.create.already_friend', username: @friend_request_form.friend.username)
    else
      flash[:error] = t('flashes.friendship.create.error')
    end

    redirect_to friendships_path
  end

  def destroy
    authorize @friendship

    @friendship.destroy!

    redirect_back fallback_location: friendships_path, flash: { success: "Unfriended #{@friendship.name}" }
  end

  def accept
    authorize @friendship

    @friendship.friend ||= current_user

    if @friendship.accept!
      flash[:success] = "Your are now friends with #{@friendship.user.username}"
    else
      flash[:error] = "Could not accept friend request"
    end

    redirect_back fallback_location: friendships_path
  end

  private

  def friend_request_params
    params.require(:friend_request_form).permit(:friend_id)
  end

  def set_friendship
    @friendship = Friendship.find_by_uuid! params[:uuid]
  end
end

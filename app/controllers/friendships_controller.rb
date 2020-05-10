class FriendshipsController < ApplicationController
  before_action :authenticate_user!, except: [:accept]

  def index
    @friendships = current_user.friendships.includes(:friend)
  end

  def new
    @friendship = Friendship.new
  end

  def create
    @friendship = Friendship.new(friendship_params.merge(user: current_user))

    if @friendship.save
      redirect_to friendships_path, flash: { success: t('flashes.friendship.create.success') }
    else
      render :new
    end
  end

  def accept
    @friendship = Friendship.find_by_uuid params[:uuid]

    if @friendship.blank?
      return redirect_to root_path, flash: { alert: 'That link has expired' }
    elsif @friendship.accepted?
      return redirect_to root_path, flash: { alert: 'That friend request has already been accepted' }
    end

    friend =  @friendship.friend || User.find_by_email(@friendship.invitation_email)

    if friend && current_user == friend
      @friendship.friend ||= friend
      @friendship.accept!

      redirect_to root_path, flash: { success: "Your are now friends with #{@friendship.user.username}" }
    else
      cookies[:friendship_uuid] = { value: @friendship.uuid, expires: 1.hour }

      if friend
        redirect_to new_user_session_path, flash: { success: 'Please log in to accept the friend request' }
      else
        redirect_to new_user_registration_path
      end
    end

  end

  def destroy
    @friendship = Friendship.find_by_uuid! params[:uuid]

    authorize @friendship

    @friendship.destroy

    redirect_back fallback_location: friendships_path, flash: { success: "Unfriended #{@friendship.name}" }
  end

  private

  def friendship_params
    params.require(:friendship).permit(:invitation_email)
  end
end

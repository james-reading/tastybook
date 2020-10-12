class InvitationsController < ApplicationController
  before_action :authenticate_user!, except: [:accept]

  def new
    @invitation_form = InvitationForm.new
  end

  def create
    @invitation_form = InvitationForm.new(
      invitation_params.merge(
        user: current_user
      )
    )

    if @invitation_form.submit
      redirect_to friendships_path, flash: { success: t('flashes.invitation.create.success', email: @invitation_form.invitation_email) }
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
      sign_out current_user

      cookies[:friendship_uuid] = { value: @friendship.uuid, expires: 1.hour }

      if friend
        redirect_to new_user_session_path, flash: { success: 'Please log in to accept the friend request' }
      else
        redirect_to new_user_registration_path
      end
    end
  end

  private

  def invitation_params
    params.require(:invitation_form).permit(:invitation_email)
  end
end

class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:check_username]

  def edit
  end

  def update
    if current_user.update_with_password(user_params)
      redirect_to edit_profile_path, flash: { success: t('flashes.settings.update.success') }
    else
      render :edit
    end
  end

  def check_username
    user = current_user || User.new
    user.username = params[:username]
    user.validate

    if user.errors[:username].any?
      render json: { error: user.errors.full_messages_for(:username).first }, status: 422
    else
      head :ok
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :current_password, :password)
  end
end

class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def edit
  end

  def update
    if current_user.update(user_params)
      redirect_to edit_profile_path, flash: { success: t('flashes.profile.update.success') }
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :bio, :image)
  end
end

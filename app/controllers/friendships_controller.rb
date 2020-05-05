class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def index
    @friendships = current_user.friendships
  end

  def new
    @friendship = current_user.friendships.new
  end

  def create
    @friendship = current_user.friendships.new(friendship_params)

    if @friendship.save
      redirect_to friendships_path, flash: { success: t('flashes.friendship.create.success') }
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  private

  def friendship_params
    params.require(:friendship).permit(:invitation_email)
  end
end

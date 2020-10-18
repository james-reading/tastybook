class Users::RecipesController < RecipesController
  before_action :set_user

  private

  def set_user
    @user = current_user.friends.find_by! 'lower(username) = ?', params[:user_username].downcase
  end

  def search_options
    super.merge(
      user: @user,
      user_recipes: true,
      friend_recipes: false,
      liked_recipes: false
    )
  end
end

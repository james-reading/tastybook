class Recipes::FriendsController < RecipesController

  private

  def search_options
    super.merge(
      user_recipes: true,
      friend_recipes: true,
      liked_recipes: true
    )
  end
end

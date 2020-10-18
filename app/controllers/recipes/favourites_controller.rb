class Recipes::FavouritesController < RecipesController

  private

  def search_options
    super.merge(
      user_recipes: false,
      friend_recipes: false,
      liked_recipes: true
    )
  end
end

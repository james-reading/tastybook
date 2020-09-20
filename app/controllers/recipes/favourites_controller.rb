class Recipes::FavouritesController < RecipesController

  private

  def search_options
    super.merge(
      liked_by_user: true,
      include_friends: true
    )
  end
end

class Recipes::FriendsController < RecipesController

  private

  def search_options
    super.merge(
      include_friends: true
    )
  end
end

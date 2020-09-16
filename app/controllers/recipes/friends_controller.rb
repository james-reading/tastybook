class Recipes::FriendsController < RecipesController

  private

  def search_options
    super.merge(
      friends_of_user: true
    )
  end
end

module RecipesHelper

  def liked?(recipe)
    return unless current_user

    user_liked_recipe_ids.include?(recipe.id)
  end

  def user_liked_recipe_ids
    @user_liked_recipe_ids ||= current_user.likes.where(likeable_type: 'Recipe').pluck(:likeable_id)
  end

  def recipe_count_heading
    case params[:controller]
    when 'recipes/friends'
      'All recipes'
    when 'recipes/favourites'
      'Favourites'
    when 'users/recipes'
      @user.username
    else
      'My recipes'
    end
  end
end

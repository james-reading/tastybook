module RecipesHelper

  def liked?(recipe)
    return unless current_user

    user_liked_recipe_ids.include?(recipe.id)
  end

  def user_liked_recipe_ids
    @user_liked_recipe_ids ||= current_user.likes.where(likeable_type: 'Recipe').pluck(:likeable_id)
  end

  def recipe_heading
    case params[:controller]
    when 'recipes/friends'
      [
        'All Recipes',
        "Here you'll find all your friend's plus your own recipes in one place."
      ]
    when 'recipes/favourites'
      [
        'Favourites',
        "Here you'll find all of the recipes that you've favourited."
      ]
    when 'users/recipes'
      [
       @user.username,
       @user.bio.presence || "A collection of #{@user.username}'s recipes."
     ]
    else
      [
        'My Recipes',
        "Here you'll find all the recipes you've created, plus any that you've favourited."
      ]
    end
  end
end

module RecipesHelper

  def liked?(recipe)
    return unless current_user

    user_liked_recipe_ids.include?(recipe.id)
  end

  def user_liked_recipe_ids
    @user_liked_recipe_ids ||= current_user.likes.where(likeable_type: 'Recipe').pluck(:likeable_id)
  end
end

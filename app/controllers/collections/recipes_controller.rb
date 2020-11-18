class Collections::RecipesController < ApplicationController
  before_action :authenticate_user!, :set_collection, :set_recipe

  def update
    unless @collection.recipes.exists?(@recipe.id)
      @collection.recipes << @recipe
    end

    head :ok
  end

  def destroy
    @collection.recipes.delete(@recipe)

    head :ok
  end

  private

  def set_collection
    @collection = current_user.collections.find params[:collection_id]
  end

  def set_recipe
    @recipe = Recipe.find params[:id]
  end
end

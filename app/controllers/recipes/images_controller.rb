class Recipes::ImagesController < ApplicationController
  before_action :authenticate_user!

  def update
    @recipe = Recipe.find params[:id]

    authorize @recipe

    if @recipe.update_attributes(recipe_params)
      flash[:success] = t('flashes.recipe.image.update.success')
    else
      flash[:error] = @recipe.errors.full_messages.to_sentence
    end

    redirect_to @recipe
  end

  def destroy
    @recipe = Recipe.find params[:id]

    authorize @recipe, :edit?

    @recipe.image.purge_later

    redirect_back fallback_location: @recipe, flash: { success: t('flashes.recipe.image.destroy.success') }
  end

  private

  def recipe_params
    params.require(:recipe).permit(:image)
  end
end

class Recipes::ImagesController < ApplicationController
  before_action :authenticate_user!

  def destroy
    @recipe = Recipe.find params[:id]

    authorize @recipe, :edit?

    @recipe.image.purge_later

    redirect_back fallback_location: @recipe, flash: { success: t('flashes.recipe.image.destroy.success') }
  end
end

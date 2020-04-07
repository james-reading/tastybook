class RecipesController < ApplicationController
  before_action :authenticate_user!

  def index
    options = {
      user: current_user
    }

    @search = Recipe::Search.new(search_params.merge(options))
    @recipes = @search.run

    respond_to :html, :js
  end

  def show
    @recipe = Recipe.find params[:id]

    authorize @recipe
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = current_user.recipes.new(recipe_params)

    if @recipe.save
      redirect_to @recipe, flash: { success: t('flashes.recipe.create.success') }
    else
      render :new
    end
  end

  def edit
    @recipe = Recipe.find params[:id]

    authorize @recipe
  end

  def update
    @recipe = Recipe.find params[:id]

    authorize @recipe

    if @recipe.update_attributes(recipe_params)
      redirect_to @recipe, flash: { success: t('flashes.recipe.update.success') }
    else
      render :edit
    end
  end

  def destroy
    @recipe = Recipe.find params[:id]

    authorize @recipe

    @recipe.destroy

    redirect_to recipes_path, flash: { success: t('flashes.recipe.destroy.success') }
  end

  private

  def recipe_params
    params.require(:recipe).permit(
      :name, :cuisine_id, :length, :servings, :link, :notes,
      ingredients_attributes: [:id, :name, :_destroy],
      steps_attributes: [:id, :description, :_destroy]
    )
  end

  def search_params
    params.fetch(:recipe_search, {}).permit(:q)
  end
end

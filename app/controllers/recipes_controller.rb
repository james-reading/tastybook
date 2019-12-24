class RecipesController < ApplicationController
  before_action :authenticate_user!

  def index
    @search = Recipe::Search.new(search_params.merge(user: current_user))
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
      redirect_to recipes_path, flash: { success: t('flashes.recipe.create.success') }
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

    if @recipe.update_attributes(recipe_params)
      redirect_to recipes_path, flash: { success: t('flashes.recipe.update.success') }
    else
      render :edit
    end
  end

  def destroy
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :cuisine_id, :length, :servings, :link)
  end

  def search_params
    params.fetch(:recipe_search, {}).permit(:q)
  end
end

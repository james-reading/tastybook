class RecipesController < ApplicationController
  before_action :authenticate_user!

  def index
    options = {
      user: current_user,
      page: params[:page]
    }

    @search = Recipe::Search.new(search_params.merge(options))
    @recipes = @search.run

    @endpoint = recipes_path
    @page_amount = 5000

    if params[:page].to_i > 1 && request.xhr?
      render @recipes
    else
      respond_to :html, :js
    end
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

    authorize @recipe

    if @recipe.update_attributes(recipe_params)
      redirect_to recipes_path, flash: { success: t('flashes.recipe.update.success') }
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
    params.require(:recipe).permit(:name, :cuisine_id, :length, :servings, :link)
  end

  def search_params
    params.fetch(:recipe_search, {}).permit(:q)
  end
end

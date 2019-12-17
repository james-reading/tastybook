class RecipesController < ApplicationController
  before_action :authenticate_user!

  def index
    @recipes = policy_scope(Recipe)
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
  end

  def update
  end

  def destroy
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :cuisine_id, :length, :link)
  end
end

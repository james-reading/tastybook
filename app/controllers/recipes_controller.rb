class RecipesController < ApplicationController
  before_action :authenticate_user!, except: :show

  def index
    @search = Recipe::Search.new(search_options)
    @recipes = @search.run

    respond_to :html, :js
  end

  def show
    @recipe = Recipe.find params[:id]
    @collection = Collection.friendly.find params[:collection_id] if params[:collection_id]

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

    if @recipe.update(recipe_params)
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

  def im_feeling_lucky
    @recipe = Recipe::Randomizer.new(search_options).run

    respond_to do |format|
      format.html { redirect_to feeling_lucky_path(@recipe) }
      format.js
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(
      :name, :cuisine_id, :length, :servings, :link, :notes, :course, :vegan, :vegetarian,
      :grab_image_url,
      ingredients_attributes: [:id, :position, :name, :heading, :_destroy],
      steps_attributes: [:id, :position, :description, :_destroy]
    )
  end

  def search_params
    params.fetch(:recipe_search, {}).permit(:q, :vegan, :vegetarian, length: [], course: [])
  end

  def search_options
    search_params.merge(
      user: current_user,
      page: params[:page],
      user_recipes: true,
      friend_recipes: false,
      liked_recipes: true
    )
  end

  def feeling_lucky_path(result)
    if result
      recipe_path result
    else
      recipes_path recipe_search: search_params
    end
  end
end

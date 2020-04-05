class Recipes::NotesController < ApplicationController
  before_action :authenticate_user!

  def edit
    @recipe = Recipe.find params[:id]

    authorize @recipe
  end
end

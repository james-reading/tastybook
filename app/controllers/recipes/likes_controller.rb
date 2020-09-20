class Recipes::LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    current_user.like(recipe)

    head :ok
  end

  def destroy
    current_user.unlike(recipe)

    head :ok
  end

  private

  def recipe
    Recipe.find params[:id]
  end
end

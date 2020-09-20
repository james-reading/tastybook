class Recipes::CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = recipe.comments.create!(
      comment_params.merge(
        user: current_user
      )
    )

    respond_to do |format|
      format.html { redirect_back fallback_location: @recipe, flash: { success: t('flashes.comment.create.success') } }
      format.js
    end
  end

  def destroy
    @comment = Comment.find params[:id]

    authorize @comment

    @comment.destroy!

    respond_to do |format|
      format.html { redirect_back fallback_location: @recipe, flash: { success: t('flashes.comment.destroy.success') } }
      format.js
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def recipe
    Recipe.find params[:id]
  end
end

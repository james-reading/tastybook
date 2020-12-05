class CollectionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_collection, only: [:edit, :update, :destroy]

  def index
    @collections = current_user.collections.order(created_at: :desc)
  end

  def show
    @user = User.find_by! 'lower(username) = ?', params[:user_username].downcase
    @collection = @user.collections.friendly.find params[:id]
  end

  def create
    @recipe = Recipe.find params[:recipe_id]
    @collection = current_user.collections.new(collection_params)

    if @collection.save
      @collection.recipes << @recipe

      render json: {
        collection_html: render_to_string(
          partial: 'collections/modal_item',
          locals: { collection: @collection, recipe: @recipe },
          formats: [:html]
        )
      }
    else
      render json: { errors: @collection.errors.to_hash(true) }, status: 422
    end
  end

  def edit
  end

  def update
    if @collection.update(collection_params)
      redirect_to user_collection_path(@collection.user.username, @collection), flash: { success: t('flashes.collection.update.success') }
    else
      render :edit
    end
  end

  def destroy
    @collection.destroy

    redirect_to collections_path
  end

  private

  def collection_params
    params.require(:collection).permit(:name, :description)
  end

  def set_collection
    @collection = current_user.collections.find params[:id]
  end
end

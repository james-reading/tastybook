require 'rails_helper'

RSpec.describe 'Recipe likes', type: :request do

  let(:user) { create :user }
  let(:recipe) { create :recipe }

  describe 'POST recipe_likes_path' do
    context 'logged out user' do
      describe 'liking a recipe' do
        it 'is redirected to authenticate ' do
          post recipe_likes_path(recipe)

          expect(response).to redirect_to new_user_session_path
        end
      end
    end

    context 'logged in user' do
      before do
        sign_in user
      end

      describe 'liking a recipe' do
        it 'creates a like' do
          post recipe_likes_path(recipe)

          expect(response).to be_successful
          expect(recipe.likes.pluck(:user_id)).to eq [user.id]
        end
      end

      describe 'liking a recipe they have liked before' do
        before do
          user.like(recipe)
        end

        it 'does not create another like' do
          post recipe_likes_path(recipe)

          expect(response).to be_successful
          expect(recipe.likes.pluck(:user_id)).to eq [user.id]
        end
      end
    end
  end

  describe 'DELETE recipe_likes_path' do
    context 'logged out user' do
      describe 'unliking a recipe' do
        it 'is redirected to authenticate ' do
          delete recipe_likes_path(recipe)

          expect(response).to redirect_to new_user_session_path
        end
      end
    end

    context 'logged in user' do
      before do
        sign_in user
      end

      describe 'unliking a recipe' do
        before do
          user.like(recipe)
        end

        it 'deletes the like' do
          delete recipe_likes_path(recipe)

          expect(response).to be_successful
          expect(recipe.likes.pluck(:user_id)).to eq []
        end
      end

      describe 'liking a recipe they have not liked already' do
        it 'is successful' do
          delete recipe_likes_path(recipe)

          expect(response).to be_successful
        end
      end
    end
  end
end

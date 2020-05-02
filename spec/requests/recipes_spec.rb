require 'rails_helper'

RSpec.describe 'Recipes', type: :request do

  let(:user) { create :user }

  context 'logged out user' do
    describe 'requesting list of all recipes' do
      it 'is redirected to authenticate ' do
        get recipes_path

        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  context 'logged in user' do
    before do
      sign_in user
    end

    describe 'requesting list of all recipes' do
      before do
        create :recipe, name: 'Fish pie', user: user

        Recipe.reindex
      end

      it 'is successful ' do
        get recipes_path

        expect(response).to be_successful
      end

      it 'renders the recipes' do
        get recipes_path

        expect(response.body).to include('Fish pie')
      end
    end
  end
end

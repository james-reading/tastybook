require 'rails_helper'

RSpec.describe 'Recipe comments', type: :system, js: true do

  let(:user) { create :user }
  let(:recipe) { create :recipe, user: user}

  it 'allows a user to add a comment' do
    sign_in user

    visit recipe_path(recipe)

    click_on 'Add a comment'

    fill_in 'comment[body]', with: 'Nice recipe you have there!'

    click_on 'Submit comment'

    expect(page).to have_field('comment[body]', with: '')

    within '#comments' do
      expect(page).to have_text('Nice recipe you have there!')
    end
  end
end

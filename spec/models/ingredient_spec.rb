require 'rails_helper'

RSpec.describe Ingredient, type: :model do

  let(:ingredient) { build_stubbed :ingredient }

  describe 'factory' do
    subject { ingredient }

    it { should be_valid }
  end
end

require 'rails_helper'

RSpec.describe Collection, type: :model do

  let(:collection) { build_stubbed :collection }

  describe 'factory' do
    subject { collection }

    it { should be_valid }
  end

  describe 'slug' do
    it 'sets a slug on create' do
      collection = create :collection, name: 'Baking stuff'

      expect(collection.slug).to eq 'baking-stuff'
    end

    it 'is scoped to the user' do
      james_collection = create :collection, name: 'Baking stuff'
      holly_collection = create :collection, name: 'Baking stuff'

      expect(james_collection.slug).to eq 'baking-stuff'
      expect(holly_collection.slug).to eq 'baking-stuff'

      conflict = create :collection, name: 'Baking stuff', user: holly_collection.user

      expect(conflict.slug).to_not eq 'baking-stuff'
      expect(conflict.slug).to include 'baking-stuff'
    end
  end
end

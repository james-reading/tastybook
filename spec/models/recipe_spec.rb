require 'rails_helper'

RSpec.describe Recipe, type: :model do

  let(:recipe) { build_stubbed :recipe }

  describe 'factory' do
    subject { recipe }

    it { should be_valid }
  end

  describe 'validations' do
    describe 'link' do
      it 'allows a valid http url' do
        recipe = build_stubbed :recipe, link: 'http://bbcgoodfood.com'
        expect(recipe).to be_valid
      end

      it 'allows a valid https url' do
        recipe = build_stubbed :recipe, link: 'https://bbcgoodfood.com'
        expect(recipe).to be_valid
      end

      it 'allows url with missing protocol' do
        recipe = build_stubbed :recipe, link: 'www.bbcgoodfood.com'
        expect(recipe).to be_valid
      end

      it 'does not allow an invalid url' do
        recipe = build_stubbed :recipe, link: 'not a url'

        expect(recipe).to_not be_valid
        expect(recipe.errors[:link]).to eq ['is not valid']
      end
    end
  end

  describe 'link_host' do
    it 'should be blank if link is blank' do
      recipe = build_stubbed :recipe, link: nil
      expect(recipe.link_host).to be_blank
    end

    it 'should return the host if the link is valid' do
      recipe = build_stubbed :recipe, link: 'https://bbcgoodfood.com/recipes/775643/cottage-pie'
      expect(recipe.link_host).to eq 'bbcgoodfood.com'
    end

    it 'handles the case where scheme is missing' do
      recipe = build_stubbed :recipe, link: 'bbcgoodfood.com/recipes/775643/cottage-pie'
      expect(recipe.link_host).to eq 'bbcgoodfood.com'
    end
  end

  describe '#grab_image' do
    context 'with blank grab_image_url' do
      let(:recipe) { build :recipe, grab_image_url: nil }

      it 'does nothing' do
        recipe.save

        expect(recipe.image.attached?).to be_falsey
      end
    end

    context 'with invalid grab_image_url' do
      let(:recipe) { build :recipe, grab_image_url: 'invalid' }

      it 'does nothing' do
        recipe.save

        expect(recipe.image.attached?).to be_falsey
      end
    end

    context 'with bad response' do
      let(:recipe) { build :recipe, grab_image_url: 'http://httpstat.us/500' }

      it 'does nothing' do
        VCR.use_cassette('down/bad_response') do
          recipe.save
        end

        expect(recipe.image.attached?).to be_falsey
      end
    end

    context 'with successful response' do
      let(:recipe) { build :recipe, grab_image_url: 'https://homepages.cae.wisc.edu/~ece533/images/airplane.png' }

      it 'attaches the image' do
        VCR.use_cassette('down/successful_response') do
          recipe.save
        end

        expect(recipe.image.attached?).to be_truthy
      end
    end
  end
end

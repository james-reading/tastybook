require 'rails_helper'

RSpec.describe Recipe::Search do

  let(:options) { {} }
  let(:service) { Recipe::Search.new(options) }

  describe '#last_page?' do
    subject { service.last_page? }

    before do
      allow(service).to receive(:total_count).and_return(10)
    end

    context 'page is less than number of pages' do
      let(:options) do
        { page: '3', per_page: '3' }
      end

      it { should be false }
    end

    context 'page is equal to number of pages' do
      let(:options) do
        { page: '4', per_page: '3' }
      end

      it { should be true }
    end

    context 'page is nil and per_page is less than number of results' do
      let(:options) do
        { page: nil, per_page: 9 }
      end

      it { should be false }
    end

    context 'page is nil and per_page is equal to number of results' do
      let(:options) do
        { page: nil, per_page: '10' }
      end

      it { should be true }
    end

    context 'page is nil and per_page is greater than number of results' do
      let(:options) do
        { page: nil, per_page: '11' }
      end

      it { should be true }
    end
  end
end

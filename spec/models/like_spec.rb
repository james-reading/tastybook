require 'rails_helper'

RSpec.describe Like, type: :model do

  let(:like) { build_stubbed :like }

  describe 'factory' do
    subject { like }

    it { should be_valid }
  end
end

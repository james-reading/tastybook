require 'rails_helper'

RSpec.describe Cuisine, type: :model do

  let(:cuisine) { build_stubbed :cuisine }

  describe 'factory' do
    subject { cuisine }

    it { should be_valid }
  end
end

require 'rails_helper'

RSpec.describe Step, type: :model do

  let(:step) { build_stubbed :step }

  describe 'factory' do
    subject { step }
    
    it { should be_valid }
  end
end

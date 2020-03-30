require 'rails_helper'

RSpec.describe User, type: :model do
  
  let(:user) { build_stubbed :user }

  describe 'factory' do
    subject { user }

    it { should be_valid }
  end
end

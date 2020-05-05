require 'rails_helper'

RSpec.describe Friendship, type: :model do
  let(:friendship) { build_stubbed :friendship }

  describe 'factory' do
    subject { friendship }

    it { should be_valid }
  end
end

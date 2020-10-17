require 'rails_helper'

RSpec.describe Comment, type: :model do

  let(:comment) { build_stubbed :comment }

  describe 'factory' do
    subject { comment }

    it { should be_valid }
  end
end

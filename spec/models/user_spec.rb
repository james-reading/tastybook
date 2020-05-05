require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user) { build_stubbed :user }

  describe 'factory' do
    subject { user }

    it { should be_valid }
  end

  describe 'friendships' do
    let(:user) { create :user }
    let(:friend) { create :user }

    it { should have_many(:friends) }

    it 'creates a reciprical friendship' do
      user.friends << friend

      expect(friend.friends).to include(user)
    end

    it 'removes the reciprical friendship on destory' do
      user.friends << friend
      user.friends = []

      expect(friend.friends).to_not include(user)
    end
  end
end

require 'rails_helper'

RSpec.describe Friendship, type: :model do
  let(:friendship) { build_stubbed :friendship }

  describe 'factory' do
    subject { friendship }

    it { should be_valid }
  end

  describe '#accept!' do
    it 'establishes a reciprocal friendship' do
      user = create :user
      friend = create :user
      friendship = create :friendship, user: user, friend: friend, accepted_at: nil, invitation_email: friend.email

      expect(user.friends).to_not include(friend)
      expect(friend.friends).to_not include(user)

      friendship.accept!

      expect(user.reload.friends).to include(friend)
      expect(friend.reload.friends).to include(user)
    end
  end
end

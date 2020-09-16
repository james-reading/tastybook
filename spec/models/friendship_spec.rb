require 'rails_helper'

RSpec.describe Friendship, type: :model do
  let(:friendship) { build_stubbed :friendship }

  describe 'factory' do
    subject { friendship }

    it { should be_valid }
  end

  describe 'friend' do
    it 'assings the friend on create if the user exists already' do
      friend = create :user
      friendship = create :friendship, invitation_email: friend.email, friend: nil

      expect(friendship.friend).to eq friend
    end

    it 'does not assign the friend if no user exists' do
      friendship = create :friendship, invitation_email: 'test@example.com', friend: nil

      expect(friendship.friend).to eq nil
    end
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

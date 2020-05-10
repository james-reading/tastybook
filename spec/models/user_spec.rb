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

    specify 'destroying the friendship destroys the reciprocal friendship' do
      friendship = create :friendship, user: user, friend: friend
      friendship.accept!

      user.friends = []

      expect(friend.friends).to_not include(user)
    end

    specify 'destroying the user destroys the friendships but not the friend' do
      friendship = create :friendship, user: user, friend: friend
      friendship.accept!

      expect {
        user.destroy!
      }.to change(Friendship, :count).by(-2)
      .and change(User, :count).by(-1)
    end
  end
end

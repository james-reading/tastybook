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
      friendship = create :friendship, user: user, friend: friend, invitation_email: friend.email
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

  describe '#friend_suggestions' do
    let(:james) { create :user, username: 'james' }
    let(:holly) { create :user, username: 'holly' }
    let(:tom) { create :user, username: 'tom' }
    let(:beth) { create :user, username: 'beth' }
    let(:pete) { create :user, username: 'pete' }

    it 'suggests friends of my friends' do
      create :friendship, :accepted, user: james, friend: holly
      create :friendship, :accepted, user: holly, friend: beth

      expect(james.friend_suggestions.pluck(:username)).to eq ['beth']
    end

    it 'does not include duplicates' do
      create :friendship, :accepted, user: james, friend: holly
      create :friendship, :accepted, user: james, friend: tom
      create :friendship, :accepted, user: holly, friend: beth
      create :friendship, :accepted, user: tom, friend: beth

      expect(james.friend_suggestions.pluck(:username)).to eq ['beth']
    end

    it 'does not include my friends' do
      create :friendship, :accepted, user: james, friend: holly
      create :friendship, :accepted, user: james, friend: beth
      create :friendship, :accepted, user: holly, friend: beth

      expect(james.friend_suggestions.pluck(:username)).to eq []
    end

    it 'does not include pending friends' do
      create :friendship, user: james, friend: holly
      create :friendship, :accepted, user: holly, friend: beth

      create :friendship, :accepted, user: james, friend: tom
      create :friendship, user: tom, friend: pete

      expect(james.friend_suggestions.pluck(:username)).to eq []
    end

    it 'orders by number of mutual friends' do
      create :friendship, :accepted, user: james, friend: holly
      create :friendship, :accepted, user: james, friend: beth

      create :friendship, :accepted, user: beth, friend: tom
      create :friendship, :accepted, user: holly, friend: tom

      create :friendship, :accepted, user: holly, friend: pete

      create :friendship, :accepted, user: pete
      create :friendship, :accepted, user: pete
      create :friendship, :accepted, user: pete

      expect(james.friend_suggestions.pluck(:username)).to eq ['tom', 'pete']
    end
  end
end

require 'rails_helper'

RSpec.describe InvitationForm do

  let(:james) { create :friend }
  let(:holly) { build :friend }

  let(:form) { InvitationForm.new(user: james, invitation_email: holly.email) }

  it 'should create a pending friend request' do
    expect {
      form.submit
    }.to change(Friendship, :count).by(1)

    friend_request = Friendship.last

    expect(friend_request).to_not be_accepted
    expect(friend_request.user).to eq james
    expect(friend_request.friend).to be_blank
    expect(friend_request.invitation_email).to eq holly.email
  end

  it 'should return truthy' do
    expect(form.submit).to be_truthy
  end

  context 'user has a friend request from the friend already' do
    let!(:friend_request) { create :friendship, :pending, user: holly, friend: james }

    it 'should accept the existing friend request' do
      expect {
        form.submit
      }.to change(Friendship, :count).from(1).to(2)

      expect(friend_request.reload).to be_accepted
    end

    it 'should return truthy' do
      expect(form.submit).to be_truthy
    end
  end

  context 'user has a friend invitation from the friend already' do
    let!(:friend_request) { create :friendship, :pending, user: holly, friend: nil, invitation_email: james.email }

    it 'should accept the existsing friend request' do
      expect {
        form.submit
      }.to change(Friendship, :count).from(1).to(2)

      expect(friend_request.reload).to be_accepted
      expect(friend_request.friend).to eq james
    end

    it 'should return truthy' do
      expect(form.submit).to be_truthy
    end
  end

  context 'user has already invited the friend' do
    let!(:friend_request) { create :friendship, :pending, user: james, friend: nil, invitation_email: holly.email }

    it 'should return falsey' do
      expect(form.submit).to be_falsey
    end

    it 'should not create a request' do
      expect {
        form.submit
      }.to_not change(Friendship, :count)

      expect(friend_request.reload).to_not be_accepted
    end
  end

  context 'user has already friend requested the friend' do
    let!(:friend_request) { create :friendship, :pending, user: james, friend: holly }

    it 'should return falsey' do
      expect(form.submit).to be_falsey
    end
  end

  context 'users are already friends' do
    let!(:friend_request) { create :friendship, :accepted, user: james, friend: holly }

    it 'should return falsey' do
      expect(form.submit).to be_falsey
    end
  end
end

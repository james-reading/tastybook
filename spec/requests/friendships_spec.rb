require 'rails_helper'

RSpec.describe 'Friendships', type: :request do

  let(:user) { create :user }
  let(:friend) { create :friend }

  describe 'GET accept_friendship_path' do
    context 'with an invalid uuid friendship' do
      it 'redirects to root' do
        get accept_friendship_path('bad')

        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to eq 'That link has expired'
      end
    end

    context 'with an already accepted friendship' do
      let(:friendship) { create :friendship, :accepted, user: user, friend: friend, invitation_email: 'friend@test.com' }

      it 'redirects to root' do
        get accept_friendship_path(friendship)

        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to eq 'That friend request has already been accepted'
      end
    end

    context 'with a pending friendship for a non existing user' do
      let(:friendship) { create :friendship, user: user, friend: nil, invitation_email: 'friend@test.com' }

      it 'redirects to sign up' do
        get accept_friendship_path(friendship)

        expect(response).to redirect_to(new_user_registration_path)
      end
    end

    context 'with a pending friendship for an existing user' do
      let(:friendship) { create :friendship, user: user, friend: friend, invitation_email: friend.email }

      context 'friend is not logged in' do
        it 'redirects to sign in' do
          get accept_friendship_path(friendship)

          expect(response).to redirect_to(new_user_session_path)
        end
      end

      context 'friend is logged in' do
        before { sign_in friend }

        it 'accepts the friendship' do
          get accept_friendship_path(friendship)

          expect(friendship.reload).to be_accepted
          expect(response).to redirect_to(root_path)
        end
      end
    end

    context 'with a pending friendship for an existing user that signed up after creating the invite' do
      let(:friendship) { create :friendship, user: user, friend: nil, invitation_email: friend.email }

      context 'friend is not logged in' do
        it 'redirects to sign in' do
          get accept_friendship_path(friendship)

          expect(response).to redirect_to(new_user_session_path)
        end
      end

      context 'friend is logged in' do
        before { sign_in friend }

        it 'accepts the friendship' do
          get accept_friendship_path(friendship)

          expect(friendship.reload).to be_accepted
          expect(friendship.friend).to eq friend
          expect(response).to redirect_to(root_path)
        end
      end
    end
  end
end

require 'rails_helper'

RSpec.describe 'Invitations', type: :request do

  let(:user) { create :user }
  let(:friend) { create :friend }

  describe 'POST invitations_path' do
    context 'with logged in user' do
      before { sign_in user }

      context 'other user is not already a friend' do
        it 'creates a pending friendship' do
          expect  {
            post invitations_path, params: { invitation_form: { invitation_email: friend.email } }
          }.to change(Friendship, :count).by(1)
          .and have_enqueued_job(ActionMailer::MailDeliveryJob).with('FriendshipsMailer', 'send_invitation', 'deliver_now', args: [instance_of(Friendship)])

          friendship = Friendship.last
          expect(friendship).to_not be_accepted
          expect(friendship.user).to eq user
          expect(friendship.friend).to eq nil
          expect(friendship.invitation_email).to eq friend.email

          expect(flash[:success]).to eq "An invitation has been sent to #{friend.email}"
          expect(response).to redirect_to(friendships_path)
        end
      end

      context 'other user is already a friend' do
        before do
          create :friendship, user: user, friend: friend
        end

        it 'renders the new template with errors' do
          post invitations_path, params: { invitation_form: { invitation_email: friend.email } }

          expect(response.body).to include('Invitation email is already one of your friends')
        end
      end

      context 'with invalid params' do
        it 'renders the errors error' do
          post invitations_path, params: { invitation_form: { invitation_email: '' } }

          expect(response.body).to include('Invitation email can&#39;t be blank')
        end
      end
    end
  end

  describe 'GET accept_invitation_path' do
    context 'with an invalid uuid friendship' do
      it 'redirects to root' do
        get accept_invitation_path('bad')

        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to eq 'That link has expired'
      end
    end

    context 'with an already accepted friendship' do
      let(:friendship) { create :friendship, :accepted, user: user, friend: friend, invitation_email: 'friend@test.com' }

      it 'redirects to root' do
        get accept_invitation_path(friendship)

        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to eq 'That friend request has already been accepted'
      end
    end

    context 'with a pending friendship for a non existing user' do
      let(:friendship) { create :friendship, user: user, friend: nil, invitation_email: 'friend@test.com' }

      it 'redirects to sign up' do
        get accept_invitation_path(friendship)

        expect(response).to redirect_to(new_user_registration_path)
      end
    end

    context 'with a pending friendship for an existing user' do
      let(:friendship) { create :friendship, user: user, friend: friend, invitation_email: friend.email }

      context 'friend is not logged in' do
        it 'redirects to sign in' do
          get accept_invitation_path(friendship)

          expect(response).to redirect_to(new_user_session_path)
        end
      end

      context 'friend is logged in' do
        before { sign_in friend }

        it 'accepts the friendship' do
          get accept_invitation_path(friendship)

          expect(friendship.reload).to be_accepted
          expect(response).to redirect_to(root_path)
        end
      end

      context 'another user is logged in' do
        before { sign_in create(:user) }

        it 'redirects to sign in' do
          get accept_invitation_path(friendship)

          expect(controller.user_signed_in?).to be_falsey
          expect(response).to redirect_to(new_user_session_path)
        end
      end
    end

    context 'with a pending friendship for an existing user that signed up after creating the invite' do
      let(:friendship) { create :friendship, user: user, friend: nil, invitation_email: friend.email }

      context 'friend is not logged in' do
        it 'redirects to sign in' do
          get accept_invitation_path(friendship)

          expect(response).to redirect_to(new_user_session_path)
        end
      end

      context 'friend is logged in' do
        before { sign_in friend }

        it 'accepts the friendship' do
          get accept_invitation_path(friendship)

          expect(friendship.reload).to be_accepted
          expect(friendship.friend).to eq friend
          expect(response).to redirect_to(root_path)
        end
      end
    end
  end
end

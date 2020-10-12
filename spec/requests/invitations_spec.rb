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
end

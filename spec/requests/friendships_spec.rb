require 'rails_helper'

RSpec.describe 'Friendships', type: :request do

  let(:user) { create :user }
  let(:friend) { create :friend }

  describe 'POST friendships_path' do
    context 'with logged in user' do
      before { sign_in user }

      context 'other user is not already a friend' do
        it 'creates a pending friendship' do
          expect  {
            post friendships_path, params: { friend_request_form: { friend_id: friend.id } }
          }.to change(Friendship, :count).by(1)
          .and have_enqueued_job(ActionMailer::MailDeliveryJob).with('FriendshipsMailer', 'send_request', 'deliver_now', args: [instance_of(Friendship)])

          friendship = Friendship.last
          expect(friendship).to_not be_accepted
          expect(friendship.user).to eq user
          expect(friendship.friend).to eq friend

          expect(flash[:success]).to eq "A request has been sent to #{friend.username}"
          expect(response).to redirect_to(friendships_path)
        end
      end

      context 'other user is already a friend' do
        before do
          create :friendship, user: user, friend: friend
        end

        it 'renders a flash alert' do
          expect  {
            post friendships_path, params: { friend_request_form: { friend_id: friend.id } }
          }.to_not change(Friendship, :count)

          expect(flash[:alert]).to eq "#{friend.username} is already your friend"
          expect(response).to redirect_to(friendships_path)
        end
      end

      context 'with invalid params' do
        it 'renders a flash error' do
          post friendships_path, params: { friend_request_form: { friend_id: '' } }

          expect(flash[:error]).to eq "Friend request could not be sent"
          expect(response).to redirect_to(friendships_path)
        end
      end
    end
  end
end

class FriendshipsMailer < ApplicationMailer
  helper :application

  def send_request(friendship)
    @friendship = friendship

    mail to: friendship.invitation_email
  end
end

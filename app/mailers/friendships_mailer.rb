class FriendshipsMailer < ApplicationMailer
  helper :application

  def send_request(friendship)
    @friendship = friendship

    mail to: friendship.friend.email, subject: "#{friendship.user.username} wants to be your friend"
  end

  def send_invitation(friendship)
    @friendship = friendship

    mail to: friendship.invitation_email, subject: "#{friendship.user.username} wants to be your friend"
  end
end

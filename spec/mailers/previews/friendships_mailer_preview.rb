class FriendshipsMailerPreview < ActionMailer::Preview

  def send_request
    # http://localhost:3000/rails/mailers/friendships_mailer/send_request
    friendship = Friendship.last

    FriendshipsMailer.send_request(friendship)
  end
end

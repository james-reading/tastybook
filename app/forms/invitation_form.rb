class InvitationForm
  include ActiveModel::Model

  attr_accessor :user, :invitation_email

  attr_reader :friendship

  validates :invitation_email,
    presence: true,
    format: { with: Devise.email_regexp, if: -> { invitation_email.present? } }

  validate :cannot_invite_self
  validate :cannot_invite_friend

  def submit
    return false if invalid?

    if received_request
      @friendship = received_request
      friendship.friend = user
      friendship.accept!

    else
      @friendship = Friendship.new(
        user: user,
        invitation_email: invitation_email
      )

      friendship.save
    end
  end

  def friend
    @friend ||= User.find_by_email invitation_email
  end

  private

  def received_request
    @received_request ||= received_friend_request.or(received_invitation_request).first
  end

  def received_friend_request
    Friendship.pending.where(
      user: friend,
      friend: user
    )
  end

  def received_invitation_request
    Friendship.pending.where(
      user: friend,
      friend: nil,
      invitation_email: user.email
    )
  end

  # Validations

  def cannot_invite_self
    if invitation_email == user.email
      errors.add(:invitation_email, :is_self)
    end
  end

  def cannot_invite_friend
    friendships = user.friendships.left_joins(:friend)

    if friendships.where(users: { email: invitation_email }).or(
        friendships.where(friend: nil, invitation_email: invitation_email)
      ).exists?

      errors.add(:invitation_email, :is_friend)
    end
  end
end

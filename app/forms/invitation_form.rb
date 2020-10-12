class InvitationForm
  include ActiveModel::Model

  attr_accessor :user, :invitation_email

  validates :invitation_email,
    presence: true,
    format: { with: Devise.email_regexp, if: -> { invitation_email.present? } }

  validate :cannot_invite_self
  validate :cannot_invite_friend

  def submit
    return false if invalid?

    friendship = user.friendships.new(
      invitation_email: invitation_email
    )

    friendship.save
  end

  private

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

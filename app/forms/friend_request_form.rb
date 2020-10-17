class FriendRequestForm
  include ActiveModel::Model

  attr_accessor :user, :friend_id

  attr_reader :friendship

  validates :friend_id, presence: true

  validate :cannot_friend_self
  validate :is_not_already_a_friend

  def submit
    return false if invalid?

    if sent_request
      # TODO: could resent email here
      @friendship = sent_request
      friendship.friend_id = friend_id
      friendship.save

    elsif received_request
      @friendship = received_request

      friendship.friend = user
      friendship.accept!

    else
      @friendship = Friendship.new(
        user: user,
        friend: friend
      )

      friendship.save
    end
  end

  def friend
    @friend ||= User.find_by_id friend_id
  end

  private

  def received_request
    @received_request ||= received_friend_request.or(received_invitation_request).first
  end

  def sent_request
    @sent_request ||= sent_friend_request.or(sent_invitation_request).first
  end

  def received_friend_request
    Friendship.pending.where(
      user_id: friend_id,
      friend: user
    )
  end

  def received_invitation_request
    Friendship.pending.where(
      user_id: friend_id,
      friend: nil,
      invitation_email: user.email
    )
  end

  def sent_friend_request
    Friendship.pending.where(
      user: user,
      friend_id: friend_id
    )
  end

  def sent_invitation_request
    return Friendship.none unless friend

    Friendship.pending.where(
      user: user,
      friend: nil,
      invitation_email: friend.email
    )
  end

  # Validations

  def cannot_friend_self
    if friend_id == user.id
      errors.add(:friend_id, :is_self)
    end
  end

  def is_not_already_a_friend
    if user.friendships.exists?(friend_id: friend_id)

      errors.add(:friend_id, :is_friend)
    end
  end
end

class FriendRequestForm
  include ActiveModel::Model

  attr_accessor :user, :friend_id

  validates :friend_id, presence: true

  def submit
    return false if invalid?

    @friendship = user.friendships.new(
      friend_id: friend_id
    )

    friendship.save
  end

  def friend
    friendship.friend if friendship
  end

  private

  attr_reader :friendship
end

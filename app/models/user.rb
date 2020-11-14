class User < ApplicationRecord
  include HasImage

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :recipes, dependent: :destroy
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships, dependent: :destroy
  has_many :friends_recipes, through: :friends, source: :recipes
  has_many :comments, dependent: :nullify
  has_many :likes, dependent: :destroy
  has_many :collections, dependent: :destroy

  validates :username,
    presence: true,
    uniqueness: { case_sensitive: false },
    format: {
      with: /\A[a-zA-Z0-9\-_]+\Z/,
      message: 'must contain only letters, numbers, dashes, and underscores',
      if: -> { username.present? } }
  validates :bio, length: { maximum: MAX_BIO_LENGTH = 150 }

  def remember_me
    true
  end

  def like(likeable)
    likeable.likes.find_or_create_by(user: self)
  end

  def unlike(likeable)
    likeable.likes.where(user: self).destroy_all
  end

  def friends(accepted: true)
    if accepted
      super().merge(friendships.accepted)
    else
      super()
    end
  end

  def friend_suggestions
    User
      .left_joins(:friendships)
      .where(friendships: { friend: friends })
      .where.not(id: friends(accepted: false))
      .where.not(id: self)
      .group(:id)
      .order('COUNT(friendships.id) DESC')
  end

  def friend_requests
    Friendship.pending.where(invitation_email: email, friend: nil).or(
      Friendship.pending.where(friend: self)
    )
  end
end

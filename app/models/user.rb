class User < ApplicationRecord
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

  validates :username, presence: true, uniqueness: { case_sensitive: false }

  def remember_me
    true
  end

  def like(likeable)
    likeable.likes.find_or_create_by(user: self)
  end

  def unlike(likeable)
    likeable.likes.where(user: self).destroy_all
  end

  def friends
    super.merge(friendships.accepted)
  end
end

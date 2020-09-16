class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :recipes
  has_many :friendships
  has_many :friends, through: :friendships, dependent: :destroy
  has_many :friends_recipes, through: :friends, source: :recipes

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

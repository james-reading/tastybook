class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :recipes

  validates :username, presence: true, uniqueness: true

  attribute :friends, default: []

  def like(likeable)
    likeable.likes.find_or_create_by(user: self)
  end

  def unlike(likeable)
    likeable.likes.where(user: self).destroy_all
  end
end

class Collection < ApplicationRecord
  extend FriendlyId

  belongs_to :user

  friendly_id :name, use: :scoped, scope: :user

  has_many :collection_recipes, dependent: :destroy
  has_many :recipes, through: :collection_recipes

  validates :name, presence: true, length: { maximum: MAX_NAME_LENGTH = 50 }
end

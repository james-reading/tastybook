class Recipe < ApplicationRecord
  belongs_to :user
  belongs_to :cuisine

  LENGTHS = ['Quick', 'Medium', 'Long'].freeze

  validates :name, presence: true
  validates :length, presence: true
  validates :length, inclusion: { in: LENGTHS }, unless: -> { length.blank? }

  delegate :name, to: :cuisine, prefix: true
end

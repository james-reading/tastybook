class Ingredient < ApplicationRecord
  belongs_to :recipe

  validates_presence_of :name

  acts_as_list scope: :recipe
end

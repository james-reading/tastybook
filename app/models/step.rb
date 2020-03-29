class Step < ApplicationRecord
  belongs_to :recipe

  validates_presence_of :description

  acts_as_list scope: :recipe
end

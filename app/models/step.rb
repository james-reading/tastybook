class Step < ApplicationRecord
  belongs_to :recipe

   acts_as_list scope: :recipe
end

class CollectionRecipe < ApplicationRecord
  belongs_to :collection, counter_cache: :recipes_count
  belongs_to :recipe
end

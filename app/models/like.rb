class Like < ApplicationRecord
  belongs_to :user
  belongs_to :likeable, polymorphic: true

  after_create :reindex_likeable
  after_destroy :reindex_likeable

  private

  def reindex_likeable
    if likeable.respond_to?(:reindex)
      likeable.reindex
    end
  end
end

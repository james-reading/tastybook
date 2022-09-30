module HasImage
  extend ActiveSupport::Concern

  ALLOWED_TYPES = %w[image/jpeg image/png image/webp].freeze

  included do
    has_one_attached :image

    validate :image_content_type
  end

  private

  def image_content_type
    return unless image.attached?

    unless image.blob.content_type.in?(ALLOWED_TYPES)
      errors.add(:image, 'is an invalid file type')
      image.purge if image.persisted?
    end
  end
end

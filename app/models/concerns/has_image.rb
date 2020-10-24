module HasImage
  extend ActiveSupport::Concern

  included do
    has_one_attached :image

    validate :image_content_type
  end

  private

  def image_content_type
    return unless image.attached?

    unless image.blob.content_type.start_with? 'image/'
      errors.add(:image, 'is an invalid file type')
      image.purge if image.persisted?
    end
  end
end

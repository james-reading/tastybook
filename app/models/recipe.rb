class Recipe < ApplicationRecord
  include Likeable, HasImage

  searchkick word_start: [:name, 'ingredients.name'], searchable: [:name, 'ingredients.name']
  has_rich_text :notes

  belongs_to :user
  belongs_to :cuisine, optional: true
  has_many :ingredients, -> { order(position: :asc) }, inverse_of: :recipe
  has_many :steps, -> { order(position: :asc) }, inverse_of: :recipe
  has_many :comments, dependent: :destroy

  LENGTHS = ['Quick', 'Medium', 'Long'].freeze
  COURSES = ['Starter', 'Main', 'Dessert', 'Side', 'Other'].freeze

  validates :name, :length, :course, presence: true
  validates :length, inclusion: { in: LENGTHS }, unless: -> { length.blank? }
  validates :course, inclusion: { in: COURSES }, unless: -> { course.blank? }
  validate :link_validator, unless: -> { link.blank? }

  accepts_nested_attributes_for :ingredients, :steps, reject_if: :all_blank, allow_destroy: true

  before_validation :grab_image, if: :grab_image_url

  scope :search_import, -> { includes(:likes, :ingredients) }

  delegate :name, to: :cuisine, prefix: true, allow_nil: true

  attr_accessor :grab_image_url

  def link_host
    link_uri.host.gsub('www.', '') if link.present?
  end

  def link_uri
    uri = URI.parse(link)
    uri = URI.parse("http://#{link}") if uri.scheme.nil?

    return uri
  end

  private

  def search_data
    {
      user_id: user_id,
      name: name,
      length: length,
      course: course,
      vegan: vegan,
      vegetarian: vegetarian,
      liked_user_ids: likes.pluck(:user_id),
      ingredients: ingredients.pluck(:name).map { |name| { name: name } }
    }
  end

  def link_validator
    begin
      valid = link_uri.instance_eval do |uri|
        uri.is_a?(URI::HTTP) && uri.host.present?
      end
    rescue URI::InvalidURIError
      valid = false
    end

    errors.add(:link, :http_url) unless valid
  end

  def grab_image
    downloaded_image = Down.download(grab_image_url)
    self.grab_image_url = nil
    image.attach(io: downloaded_image, filename: downloaded_image.original_filename)

  rescue Down::Error
    return true # For now we fail silently
  end
end

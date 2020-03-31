class Recipe < ApplicationRecord
  searchkick word_start: [:name], searchable: [:name]

  belongs_to :user
  belongs_to :cuisine, optional: true
  has_many :ingredients
  has_many :steps, -> { order(position: :asc) }

  LENGTHS = ['Quick', 'Medium', 'Long'].freeze

  validates :name, presence: true
  validates :length, inclusion: { in: LENGTHS }, unless: -> { length.blank? }
  validate :link_validator, unless: -> { link.blank? }

  accepts_nested_attributes_for :ingredients, :steps, reject_if: :all_blank, allow_destroy: true

  delegate :name, to: :cuisine, prefix: true, allow_nil: true

  def link_host
    link_uri.host.gsub('www.', '') if link.present?
  end

  def link_uri
    uri = URI.parse(link)
    uri = URI.parse("http://#{link}") if uri.scheme.nil?

    return uri
  end

  private

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
end

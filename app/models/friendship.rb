class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User', optional: true

  after_destroy :destroy_reciprocal_friendship

  validates :invitation_email,
    presence: true,
    format: { with: Devise.email_regexp, if: -> { invitation_email.present? } },
    uniqueness: { scope: :user }

  delegate :username, to: :friend, allow_nil: true

  def accepted?
    accepted_at.present?
  end

  private

  def create_reciprocal_friendship
    Friendship.default_scoped.find_or_create_by!(user: friend, friend: user)
  end

  def destroy_reciprocal_friendship
    Friendship.default_scoped.find_by(user: friend, friend: user)&.destroy!
  end
end

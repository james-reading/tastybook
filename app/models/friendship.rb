class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User', optional: true

  before_validation :sanitize_invitation_email
  before_create :set_uuid
  after_destroy :destroy_reciprocal_friendship

  validates :friend, presence: true, if: -> { accepted? }
  validate :cannot_beforend_self

  with_options unless: :accepted? do
    before_create :set_friend
    after_create :send_request_email

    validates :invitation_email,
      presence: true,
      format: { with: Devise.email_regexp, if: -> { invitation_email.present? } },
      uniqueness: { scope: :user }
  end

  delegate :username, to: :friend, allow_nil: true

  scope :accepted, -> { where.not(accepted_at: nil) }

  def accept!
    touch :accepted_at

    create_reciprocal_friendship
  end

  def accepted?
    accepted_at.present?
  end

  def to_param
    uuid
  end

  def name
    friend&.username || invitation_email
  end

  private

  def set_friend
    self.friend ||= User.find_by_email(invitation_email)
  end

  def create_reciprocal_friendship
    Friendship.default_scoped.find_or_initialize_by(user: friend, friend: user).tap do |friendship|
      friendship.accepted_at = accepted_at
      friendship.save!
    end
  end

  def destroy_reciprocal_friendship
    Friendship.default_scoped.find_by(user: friend, friend: user)&.destroy!
  end

  def set_uuid
    begin
      self.uuid = SecureRandom.hex(4)
    end while self.class.exists?(uuid: uuid)
  end

  def send_request_email
    FriendshipsMailer.send_request(self).deliver_later
  end

  def sanitize_invitation_email
    if invitation_email
      self.invitation_email = invitation_email.strip.downcase
    end
  end

  def cannot_beforend_self
    if invitation_email == user.email
      errors.add(:invitation_email, :is_self)
    end
  end
end

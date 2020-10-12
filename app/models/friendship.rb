class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User', optional: true

  before_validation :sanitize_invitation_email
  before_create :set_uuid
  after_destroy :destroy_reciprocal_friendship
  after_commit :send_email, on: :create, unless: :accepted?

  delegate :username, to: :friend, allow_nil: true

  scope :accepted, -> { where.not(accepted_at: nil) }
  scope :pending, -> { where(accepted_at: nil) }

  def accept!
    self.accepted_at = Time.now

    if save
      create_reciprocal_friendship
    end
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

  def send_email
    if friend
      FriendshipsMailer.send_request(self).deliver_later
    else
      FriendshipsMailer.send_invitation(self).deliver_later
    end
  end

  def sanitize_invitation_email
    if invitation_email
      self.invitation_email = invitation_email.strip.downcase
    end
  end
end

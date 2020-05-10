class RenameInvitationTokenToUuid < ActiveRecord::Migration[6.0]
  def change
    rename_column :friendships, :invitation_token, :uuid
  end
end

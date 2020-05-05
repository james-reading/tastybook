class CreateFriendships < ActiveRecord::Migration[6.0]
  def change
    create_table :friendships do |t|
      t.references :user, null: false, foreign_key: true, index: true
      t.references :friend, foreign_key: { to_table: :users }, index: true
      t.string   :invitation_token
      t.string   :invitation_email
      t.datetime :accepted_at

      t.timestamps null: false
    end

    add_index :friendships, :invitation_token, unique: true
  end
end

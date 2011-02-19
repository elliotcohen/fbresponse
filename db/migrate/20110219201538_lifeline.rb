class Lifeline < ActiveRecord::Migration
  def self.up
    create_table(:lifelines) do |t|
      t.timestamps
      t.integer :user_id
      t.string :facebook_uid
    end
  end

  def self.down
    drop_table(:users)
  end
end

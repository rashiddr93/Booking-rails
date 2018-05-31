class CreateSessionStores < ActiveRecord::Migration[5.1]
  def change
    create_table :session_stores do |t|
      t.string :session_key
      t.date :session_expiry
      t.boolean :is_active
      t.string :user_id

      t.timestamps
    end
  end
end

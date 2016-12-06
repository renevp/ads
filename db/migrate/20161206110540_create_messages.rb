class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.integer :sender_id
      t.integer :recipient_id
      t.integer :advertisement_id
      t.integer :status
      t.string :body

      t.timestamps
    end

    add_index :messages, :sender_id
    add_index :messages, :recipient_id
    add_index :messages, :advertisement_id
  end
end

class CreateAdvertisements < ActiveRecord::Migration[5.0]
  def change
    create_table :advertisements do |t|
      t.string :title
      t.string :description
      t.integer :amount

      t.timestamps
    end
  end
end

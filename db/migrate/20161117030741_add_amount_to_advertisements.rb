class AddAmountToAdvertisements < ActiveRecord::Migration[5.0]
  def up
    add_column :advertisements, :amount, :integer

    Advertisement.reset_column_information

    Advertisement.all.each do |ad|
      ad.amount = 0
      ad.save!
    end

    change_column_null :advertisements, :amount, false
  end

  def down
    remove_column :advertisements, :amount, :integer
  end
end

class RemoveAmountFromAdvertisements < ActiveRecord::Migration[5.0]
  def change
    remove_column :advertisements, :amount, :integer
  end
end

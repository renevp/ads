class AddAdTypeToAdvertisements < ActiveRecord::Migration[5.0]
  def change
    add_column :advertisements, :ad_type, :integer
  end
end

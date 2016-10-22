class AddStatusToAdvertisements < ActiveRecord::Migration[5.0]
  def change
    add_column :advertisements, :status, :integer
  end
end

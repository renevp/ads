class AddMoneyToAdvertisements < ActiveRecord::Migration[5.0]
  def change
    add_monetize :advertisements, :price
  end
end

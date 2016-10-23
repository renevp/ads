class AddMoneyToAdvertisements < ActiveRecord::Migration[5.0]
  def change
    add_money :advertisements, :price
  end
end

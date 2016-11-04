class ChangeColumnDefaultToUsers < ActiveRecord::Migration[5.0]
  def up
    change_column :users, :verified, :boolean, default: false
    change_column :users, :status, :integer, default: 0
  end

  def down
    change_column :users, :verified, :boolean, default: nil 
    change_column :users, :status, :integer, default: nil
  end
end

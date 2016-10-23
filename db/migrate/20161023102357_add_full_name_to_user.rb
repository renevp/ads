class AddFullNameToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :full_name, :string

    add_column :users, :username, :string

    add_column :users, :verified, :boolean

    add_column :users, :status, :integer

    add_column :users, :mobile_number, :string
  end
end

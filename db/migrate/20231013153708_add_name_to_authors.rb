class AddNameToAuthers < ActiveRecord::Migration[6.1]
  def change
    add_column :authers, :name, :string
  end
end

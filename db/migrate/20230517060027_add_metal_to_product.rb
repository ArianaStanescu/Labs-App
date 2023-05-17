class AddMetalToProduct < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :metal, :string
    add_index :products, :metal
  end
end

class AddSizeToProduct < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :size, :string
    add_index :products, :size
  end
end

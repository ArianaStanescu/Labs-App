class AddProductImageToProduct < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :product_image, :string
    add_index :products, :product_image
  end
end

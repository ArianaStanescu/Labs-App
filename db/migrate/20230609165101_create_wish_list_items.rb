class CreateWishListItems < ActiveRecord::Migration[7.0]
  def change
    create_table :wish_list_items do |t|
      t.bigint :user_id, null: false
      t.bigint :product_id, null: false
      t.timestamps
    end
  end
end

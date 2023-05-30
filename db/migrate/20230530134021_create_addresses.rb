class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.bigint :user_id, null: false
      t.string :country, null: false
      t.string :city, null: false
      t.string :street, null: false
      t.string :zip, null: false
      t.bigint :address_type, null: false, default: 2
      t.timestamps
    end
  end
end

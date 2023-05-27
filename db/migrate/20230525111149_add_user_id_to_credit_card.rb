class AddUserIdToCreditCard < ActiveRecord::Migration[7.0]
  def change
    add_column :credit_cards, :user_id, :bigint
    add_index :credit_cards, :user_id
  end
end

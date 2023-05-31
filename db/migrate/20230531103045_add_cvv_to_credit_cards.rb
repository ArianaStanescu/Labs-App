class AddCvvToCreditCards < ActiveRecord::Migration[7.0]
  def change
    add_column :credit_cards, :cvv, :string
    add_column :credit_cards, :name, :string
  end
end

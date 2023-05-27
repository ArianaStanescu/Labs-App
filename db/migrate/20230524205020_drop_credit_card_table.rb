class DropCreditCardTable < ActiveRecord::Migration[7.0]
  def up
    drop_table :credit_cards
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end


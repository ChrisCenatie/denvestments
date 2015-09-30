class AddCreditCardNumberToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :card_number, :string
    add_column :orders, :card_expiration, :string
    add_column :orders, :status, :string
  end
end

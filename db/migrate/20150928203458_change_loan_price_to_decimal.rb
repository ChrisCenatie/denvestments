class ChangeLoanPriceToDecimal < ActiveRecord::Migration
  def change
    change_column :loans, :price, :decimal
  end
end

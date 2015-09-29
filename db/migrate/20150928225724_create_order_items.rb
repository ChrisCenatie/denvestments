class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.integer :loan_id
      t.integer :order_id
      t.integer :quantity
      t.timestamps null: false
    end
  end
end

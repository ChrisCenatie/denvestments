class RemoveColumnFromOrders < ActiveRecord::Migration
  def change
    remove_column :orders, :status_id, :integer
    drop_table :statuses
  end
end

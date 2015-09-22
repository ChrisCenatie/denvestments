class AddImageToLoans < ActiveRecord::Migration
  def change
    add_attachment :loans, :avatar
  end
end

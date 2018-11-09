class AddColToOrder < ActiveRecord::Migration[5.2]
  def change
  	add_column :orders, :payment_method_id, :integer
  	add_column :orders, :payment_received, :boolean
  end
end

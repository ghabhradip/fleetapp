class ChangeColTypeOrders < ActiveRecord::Migration[5.2]
  def change
  	change_column :orders, :pickup_time, :time
  	change_column :orders, :delivery_time, :time
  	add_column :orders, :pickup_date, :date
  	add_column :orders, :delivery_date, :date
  end
end

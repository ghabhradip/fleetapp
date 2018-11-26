class AddLocColsToOrders < ActiveRecord::Migration[5.2]
  def change
  	add_column :orders, :pickup_location_latitude, :string
  	add_column :orders, :pickup_location_longitude, :string
  	add_column :orders, :delivery_location_latitude, :string
  	add_column :orders, :delivery_location_longitude, :string
  end
end

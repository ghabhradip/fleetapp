class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :customer_name
      t.integer :user_id
      t.text :pickup_address
      t.text :delivery_address
      t.datetime :pickup_time
      t.datetime :delivery_time
      t.boolean :scheduled_delivery_request
      t.boolean :for_self

      t.timestamps
    end
  end
end

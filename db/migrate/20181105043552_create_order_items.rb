class CreateOrderItems < ActiveRecord::Migration[5.2]
  def change
    create_table :order_items do |t|
      t.string :name
      t.decimal :approximate_weight
      t.decimal :actual_weight
      t.integer :order_id

      t.timestamps
    end
  end
end

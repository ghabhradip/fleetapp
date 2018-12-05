class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.integer :order_id
      t.integer :payment_method_id
      t.string :status
      t.integer :payment_gateway_id
      t.text :payment_response_body

      t.timestamps
    end
  end
end

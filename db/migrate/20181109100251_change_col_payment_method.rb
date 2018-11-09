class ChangeColPaymentMethod < ActiveRecord::Migration[5.2]
  def change
  	change_column :payment_methods, :type, :name
  end
end

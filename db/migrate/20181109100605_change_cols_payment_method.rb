class ChangeColsPaymentMethod < ActiveRecord::Migration[5.2]
  def change
  	rename_column :payment_methods, :type, :name
  	change_column :payment_methods, :name, :string
  end
end

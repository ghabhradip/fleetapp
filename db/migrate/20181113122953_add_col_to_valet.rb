class AddColToValet < ActiveRecord::Migration[5.2]
  def change
  	add_column :valets, :contact_number, :string
  end
end

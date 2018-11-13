class CreateValets < ActiveRecord::Migration[5.2]
  def change
    create_table :valets do |t|
      t.string :name
      t.text :address
      t.string :aadhar_number
      t.string :voter_id_number
      t.string :current_latitude
      t.string :current_longitude
      t.boolean :available

      t.timestamps
    end
  end
end

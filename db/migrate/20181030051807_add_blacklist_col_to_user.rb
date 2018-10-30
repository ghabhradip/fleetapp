class AddBlacklistColToUser < ActiveRecord::Migration[5.2]
  def change
  	add_column :users, :is_blacklisted, :boolean
  end
end

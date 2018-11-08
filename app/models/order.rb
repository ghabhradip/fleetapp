class Order < ApplicationRecord
	belongs_to :user
	has_many :order_items


	def self.cost(weight)
		if weight < 1000
			cost = 20
		elsif weight >= 1000 && weight < 5000
			cost = 50
		elsif weight >= 5000
			cost = 100		
		end
	end
end

class Order < ApplicationRecord
	belongs_to :user
	# belongs_to :valet
	has_many :order_items
	has_one :payment_method
	after_save :notify_pusher, on: :update

	def self.cost(weight)
		if weight < 1000
			cost = 20
		elsif weight >= 1000 && weight < 5000
			cost = 50
		elsif weight >= 5000
			cost = 100		
		end
	end

	def notify_pusher
       Pusher.trigger('feed', 'order-update', self.as_json)
    end
end

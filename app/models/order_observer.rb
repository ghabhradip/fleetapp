class OrderObserver < ActiveRecord::Observer
  require 'loc'
  def after_create(order)
    #OrderWorker.perform_in(1.minutes,order.id)
	#OrderWorker.new.perform(order.id)

  	current_user = User.find(order.user_id)

	@notification = Notification.new
 	@notification.user_id = current_user.id
    @notification.details = "Order "+ order.id.to_s+"  successfully placed."
    @notification.read = nil
    @notification.notification_type = "order placed"
  
    if @notification.save
     Pusher.trigger('my-channel', 'order-update', {
      message: current_user.unread_notification_count.to_s,
      type: "order placed"
     })
    end

	self.assign_valet(order.id)

  end


# This is the simplest alogorithm to calculate distance between available valet and order pickup location. This will never be used in production. This is just for testing purpose.

  def assign_valet(order_id)
  	valet_hash = Hash.new
  	@order = Order.find(order_id.to_i)
  	current_user = User.find(@order.user_id)
  	@available_valets = Valet.where(:available => true)
  	@available_valets.each do |valet|
  		valet_current_location = Loc::Location[valet.current_latitude.to_f, valet.current_longitude.to_f]
  		order_pickup_location = Loc::Location[@order.pickup_location_latitude.to_f, @order.pickup_location_longitude.to_f]
 		distance = valet_current_location.distance_to(order_pickup_location)
 		valet_hash[valet.id] = distance	
  	end
  	
  	#sorting the valet hash based on the distance value
  	sorted_valet_hash = valet_hash.sort_by {|_key, value| value}.to_h
  	assigned_valet_id = sorted_valet_hash.keys[0]
  	assigned_valet =  Valet.find(assigned_valet_id)
  	assigned_valet.update_attributes(:available => false)

  	@notification = Notification.new
	@notification.user_id = current_user.id
	@notification.details = assigned_valet.name+" will pickup your order soon."
	@notification.read = nil
	@notification.notification_type = "valet assigned"

	if @notification.save
	  	Pusher.trigger('my-channel', 'order-update', {
	          message: current_user.unread_notification_count.to_s,
	          type: 'valet assigned',
	          valet: assigned_valet.name
	    })
	end
  end
end
class OrderObserver < ActiveRecord::Observer
  def after_save(order)
  	puts "in observer just after placing the order--------"
    OrderWorker.perform_in(1.minute,order.id)
  end
end
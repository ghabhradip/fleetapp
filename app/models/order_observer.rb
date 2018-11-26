class OrderObserver < ActiveRecord::Observer
  def after_save(order)
    #OrderWorker.perform_in(1.minutes,order.id)
    OrderWorker.new.perform(order.id)
  end
end
class OrderWorker
  include Sidekiq::Worker
  sidekiq_options queue: "high"

  def perform(order_id)
    # Do something
    puts "valet will be assigned soon for........."+order_id.to_s
  end
end

# Sidekiq.configure_client do |config|
#   config.redis = { url: "localhost:6379"}
# end


Sidekiq.configure_client do |config|
  config.redis = { :size => 1 }
end

Sidekiq.configure_server do |config|
  config.redis = { :size => 16 }
end
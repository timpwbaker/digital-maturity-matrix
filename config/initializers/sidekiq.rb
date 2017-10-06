require "sidekiq/web"

Sidekiq.configure_server { |config| config.redis = { driver: :hiredis, url: ENV.fetch("REDIS_URL") } }
Sidekiq.configure_client { |config| config.redis = { driver: :hiredis, url: ENV.fetch("REDIS_URL") } }

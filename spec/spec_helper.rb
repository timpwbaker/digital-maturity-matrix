require 'simplecov'
SimpleCov.start
require 'capybara/rspec'
require 'webmock/rspec'
require 'sidekiq/testing'
Sidekiq::Testing.fake!

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.before(:each) do
    Sidekiq::Worker.clear_all
  end
end

WebMock.disable_net_connect! allow_localhost: true

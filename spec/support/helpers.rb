require 'support/helpers/session_helpers'
require 'support/helpers/aws_helpers'
RSpec.configure do |config|
  config.include Features::SessionHelpers, type: :feature
  config.include Features::AwsHelpers
end

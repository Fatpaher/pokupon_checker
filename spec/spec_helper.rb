require 'rspec'
require 'pry'
require 'webmock/rspec'
require 'mail'
require 'timecop'

require_relative '../config/init'

ENV['RACK_ENV'] = 'test'

include Mail::Matchers

WebMock.enable!

Mail.defaults do
  delivery_method :test
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.disable_monkey_patching!
  config.warnings = true
  if config.files_to_run.one?
    config.default_formatter = "doc"
  end
  config.order = :random
end

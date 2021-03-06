require "simplecov"
SimpleCov.start

require "bundler/setup"
require "ostruct"

require_relative "../lib/apple_store_inventory_checker"
require_relative "./fake_client"

require "webmock/rspec"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

def setup
  AppleStoreInventoryChecker.client = AppleStoreInventoryChecker::FakeClient
end

setup

begin
  require "pry"
rescue StandardError; end # rubocop:disable Lint/HandleExceptions
require "json"

require_relative "apple_store_inventory_checker/api_client"
require_relative "apple_store_inventory_checker/api_request"
require_relative "apple_store_inventory_checker/result"
require_relative "apple_store_inventory_checker/results_list"
require_relative "apple_store_inventory_checker/version"

module AppleStoreInventoryChecker
  class << self
    attr_writer :client

    BASE_URL = "https://www.apple.com/shop/retail/pickup-message".freeze

    def base_url
      BASE_URL
    end

    def client
      @client ||= AppleStoreInventoryChecker::APIClient
    end

    def retrieve(product_id, zip:, max_distance: 15.0)
      instance = ResultsList.new(product_id, zip: zip, max_distance: max_distance)
      instance.refresh
    end
  end

  class Error < StandardError; end
end

require "apple_store_inventory_checker/result"
require "apple_store_inventory_checker/results_list"
require "apple_store_inventory_checker/version"

module AppleStoreInventoryChecker
  class << self
    def retrieve(_product, zip:, max_distance: 15)
      ResultsList.new
    end
  end
  class Error < StandardError; end
end

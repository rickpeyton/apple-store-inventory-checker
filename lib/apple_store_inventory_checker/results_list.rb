module AppleStoreInventoryChecker
  class ResultsList < APIRequest
    include Enumerable

    attr_accessor :max_distance
    attr_accessor :product_id
    attr_accessor :results
    attr_accessor :zip

    def initialize(product_id, zip:, max_distance: 15.0)
      @product_id = product_id
      @zip = zip
      @max_distance = max_distance
    end

    def refresh
      response = request(:get, query: { "parts.0" => @product_id, location: @zip })
      raw_results = response.dig(:body, :stores)
      self.results = refresh_list_objects(raw_results, max_distance: @max_distance)
      self
    end

    def each
      results.each do |result|
        yield(result)
      end
    end

  private

    def refresh_list_objects(raw_results, max_distance:)
      raw_results.map do |raw_result|
        result = Result.new(product_id: product_id)
        result.product = raw_result.dig(:partsAvailability, product_id.to_sym, :storePickupProductTitle)
        result.in_stock = raw_result.dig(:partsAvailability, product_id.to_sym, :storePickupQuote).include?("Today")
        result.distance = raw_result.dig(:storedistance).to_f
        result.store = raw_result.dig(:storeName)
        result.city = raw_result.dig(:city)
        result.state = raw_result.dig(:state)
        result.phone = raw_result.dig(:phoneNumber)
        result.url = raw_result.dig(:directionsUrl)
        result
      end.select { |result| result&.distance < max_distance }
    end
  end
end

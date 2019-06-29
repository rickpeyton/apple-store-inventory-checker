module AppleStoreInventoryChecker
  class APIRequest
    class << self; end

  private

    def request(_method, query: {})
      url_params = to_url_params(query)
      uri = URI("#{AppleStoreInventoryChecker.base_url}?#{url_params}")
      response = AppleStoreInventoryChecker.client.get(uri)

      JSON.parse(response.body, symbolize_names: true)
    end

    def to_url_params(query)
      URI.encode_www_form(query)
    end
  end
end

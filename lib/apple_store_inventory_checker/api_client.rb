module AppleStoreInventoryChecker
  class APIClient
    class << self
      def get(uri)
        http = setup_http(uri)
        req = Net::HTTP::Get.new(uri)
        req.add_field "Accept", "application/json"
        http.request(req)
      end

      def setup_http(uri)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_PEER
        http
      end
    end
  end
end

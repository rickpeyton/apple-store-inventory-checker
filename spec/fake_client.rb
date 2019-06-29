module AppleStoreInventoryChecker
  class FakeClient
    class << self
      def get(_uri)
        response = File.read("spec/powerbeats_37064_response.txt")
        OpenStruct.new(
          body: response
        )
      end
    end
  end
end

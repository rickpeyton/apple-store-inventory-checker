RSpec.describe AppleStoreInventoryChecker do
  it "has a version number" do
    expect(AppleStoreInventoryChecker::VERSION).not_to be nil
  end

  describe ".retrieve" do
    it "retrieves inventory status from the Apple Store" do
      actual = AppleStoreInventoryChecker.retrieve("MV6Y2LL/A", zip: "37064", max_distance: 160)
      first_result = actual.first
      last_result = actual.results.last

      expect(actual).to be_a AppleStoreInventoryChecker::ResultsList
      expect(first_result).to be_a AppleStoreInventoryChecker::Result

      binding.pry

      expect(first_result.product).to eq("Powerbeats Pro - Totally Wireless Earphones - Black")
      expect(first_result.in_stock?).to eq(false)
      expect(first_result.distance).to eq(4.76)
      expect(first_result.store).to eq("CoolSprings Galleria")
      expect(first_result.city).to eq("Franklin")
      expect(first_result.state).to eq("TN")
      expect(first_result.phone).to eq("615-435 0620")
      expect(first_result.url).to eq("http://www.apple.com/retail/coolspringsgalleria")

      expect(last_result.product).to eq("Powerbeats Pro - Totally Wireless Earphones - Black")
      expect(last_result.in_stock?).to eq(true)
      expect(last_result.distance).to eq(158.76)
      expect(last_result.store).to eq("West Town Mall")
      expect(last_result.city).to eq("Knoxville")
      expect(last_result.state).to eq("TN")
      expect(last_result.phone).to eq("865-824 2507")
      expect(last_result.url).to eq("http://www.apple.com/retail/westtownmall")
    end
  end
end

RSpec.describe AppleStoreInventoryChecker::ResultsList do
  describe "#stock_status" do
    it "handles today" do
      list = AppleStoreInventoryChecker::ResultsList.new("", zip: "")

      actual = list.send(:stock_status, "Today at Apple West Town Mall")

      expect(actual).to eq(true)
    end

    it "handles tomorrow" do
      list = AppleStoreInventoryChecker::ResultsList.new("", zip: "")

      actual = list.send(:stock_status, "Tomorrow at Apple West Town Mall")

      expect(actual).to eq(true)
    end

    it "returns false if it is not today or tomorrow" do
      list = AppleStoreInventoryChecker::ResultsList.new("", zip: "")

      actual = list.send(:stock_status, "Jul 25 at Apple CoolSprings Galleria")

      expect(actual).to eq(false)
    end
  end
end

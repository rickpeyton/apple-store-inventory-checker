RSpec.describe "Call to Apple Store returns valid result" do
  it "returns a valid result object from a call to the Apple Store" do
    WebMock.allow_net_connect!
    AppleStoreInventoryChecker.client = AppleStoreInventoryChecker::APIClient

    actual = AppleStoreInventoryChecker.retrieve("MV6Y2LL/A", zip: "37064")

    expect(actual.results.size).to eq(2)

    expect(actual.first.product).to be_a String
    expect(actual.first.in_stock?).to be(true).or(be(false))
    expect(actual.first.distance).to be_a Float
    expect(actual.first.store).to be_a String
    expect(actual.first.city).to be_a String
    expect(actual.first.state).to be_a String
    expect(actual.first.phone).to be_a String
    expect(actual.first.url).to be_a String

    AppleStoreInventoryChecker.client = AppleStoreInventoryChecker::FakeClient
    WebMock.disable_net_connect!
  end
end

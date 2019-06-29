module AppleStoreInventoryChecker
  class ResultsList
    include Enumerable

    attr_accessor :results

    def initialize
      self.results = [Result.new]
    end

    def each
      results.each do |result|
        yield(result)
      end
    end
  end
end

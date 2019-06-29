module AppleStoreInventoryChecker
  class Result
    attr_accessor :city
    attr_accessor :distance
    attr_accessor :phone
    attr_accessor :product
    attr_accessor :state
    attr_accessor :store
    attr_accessor :url

    attr_reader :product_id

    attr_writer :in_stock

    def initialize(product_id:)
      @product_id = product_id
    end

    def in_stock?
      @in_stock
    end
  end
end

# frozen_string_literal: true

module Cashier
  # This class represents the item to be scanned at checkout.
  class Item
    attr_reader :code, :name, :price

    # Public: Initializes the item.
    # code  - A `String` that identifies the item.
    # name  - The actual name of the item.
    # price - The original price of the item.
    def initialize(code, name, price)
      @code  = code
      @name  = name
      @price = BigDecimal(price)
    end
  end
end

# frozen_string_literal: true

module Cashier
  # This class represents the item to be scanned at checkout.
  class Product
    attr_reader :code, :name, :price

    def initialize(code, name, price)
      @code  = code
      @name  = name
      @price = BigDecimal(price.to_s)
    end
  end
end

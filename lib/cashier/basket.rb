# frozen_string_literal: true

module Cashier
  # This class represents the basket where all the items are going to be added.
  class Basket
    include Cashier::ItemValidator

    attr_reader :items, :size, :total_price

    # Public: Initializes the basket.
    def initialize
      @items       = {}
      @total_price = BigDecimal(0)
    end

    # Public: Adds one item to the `@items` hash and sums its price to the `@total_price`.
    # The `code` of the `item` points to an integer that determines the quantity of that item.
    # item - The item to be added.
    def add_item(item)
      return false unless valid_item?(item)

      item_code = item.code

      @items[item_code] ? @items[item_code] += 1 : @items[item_code] = 1
      @total_price += item.price

      true
    end
  end
end

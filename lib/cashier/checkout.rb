# frozen_string_literal: true

module Cashier
  # This class receives the basket and the rules to be applied to it.
  class Checkout
    attr_reader :pricing_rules, :basket

    # Public: Initializes the checkout.
    # pricing_rules - An instance of `Cashier::PricingRulesList`; it contains all the `princing_rule`s
    #                 that will be applied to each `item` from the `basket`.
    # basket        - An instance of `Cashier::Basket` where all the `item`s are scanned (added).
    def initialize(pricing_rules, basket = Basket.new)
      @pricing_rules = pricing_rules
      @basket        = basket
    end

    # Public: Scans the given `item`.
    # item - The item to be scanned.
    def scan(item)
      basket.add_item(item)
    end

    # Public: Process the total price of the basket and subtracts the discount price.
    #
    # Returns the total price with the discounts applied (if any).
    def total
      basket.total_price - pricing_rules.discounts(basket)
    end
  end
end

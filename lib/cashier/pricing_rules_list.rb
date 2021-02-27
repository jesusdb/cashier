# frozen_string_literal: true

module Cashier
  # This class has a list of the pricing rules added to the initializer.
  class PricingRulesList
    attr_reader :pricing_rules

    # Public: Initializes the pricing rules list.
    # *pricing_rules - A list of `pricing_rule`s.
    def initialize(*pricing_rules)
      @pricing_rules = pricing_rules
    end

    # Public: Applies the discount to each `item` from the `basket` and sums all of them.
    # basket - The basket that contains the `item`s.
    #
    # Returns the total of the discounts of each `item` of the `basket`.
    def discounts(basket)
      pricing_rules
        .map { |pricing_rule| pricing_rule.discount(basket.items[pricing_rule.item.code] || 0) }
        .sum
    end
  end
end

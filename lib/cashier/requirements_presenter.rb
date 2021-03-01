# frozen_string_literal: true

module Cashier
  class RequirementsPresenter
    ITEM_CODES  = %w[GR1 SR1 CF1].freeze
    ITEM_NAMES  = %w[Green\ Tea Strawberries Coffee].freeze
    ITEM_PRICES = %w[3.11 5.0 11.23].freeze

    PRICING_RULE_NAMES = [
      'Buy-one-get-one-free',
      '10% discount when having 3 or more strawberries',
      'Drop of price to two thirds of the original price when buying 3 or more coffees'
    ].freeze
    PRICING_RULE_DISCOUNT_PERCENTAGES = [
      100.0 * (1 / 2.0), # Same as 50.0%]
      10.0,
      100.0 * (1 - 2 / 3.0) # Same as 33.33%...
    ].freeze
    PRICING_RULE_STARTING_QUANTITY = [2, 3, 3].freeze
    PRICING_RULE_GREEDS = [false, true, true].freeze

    attr_reader :items, :pricing_rules

    def initialize
      @items = nil
      @pricing_rules = nil
    end

    def present
      initialize_items
      initialize_pricing_rules

      present_results
    end

    def present_results
      4.times { |index| puts send("requirement#{index + 1}") }
    end

    def initialize_items
      @items = Array.new(3) { |index| Cashier::Item.new(ITEM_CODES[index], ITEM_NAMES[index], ITEM_PRICES[index]) }
    end

    def initialize_pricing_rules
      @pricing_rules = PricingRulesList.new(
        *Array.new(3) do |index|
          Cashier::PricingRule.new(
            PRICING_RULE_NAMES[index],
            PRICING_RULE_DISCOUNT_PERCENTAGES[index],
            PRICING_RULE_STARTING_QUANTITY[index],
            items[index],
            PRICING_RULE_GREEDS[index]
          )
        end
      )
    end

    def initialize_checkout
      Cashier::Checkout.new(pricing_rules)
    end

    def requirement1
      co = initialize_checkout
      co.scan(items[0])
      co.scan(items[1])
      co.scan(items[0])
      co.scan(items[0])
      co.scan(items[2])
      co.total.to_f
    end

    def requirement2
      co = initialize_checkout
      co.scan(items[0])
      co.scan(items[0])
      co.total.to_f
    end

    def requirement3
      co = initialize_checkout
      co.scan(items[1])
      co.scan(items[1])
      co.scan(items[0])
      co.scan(items[1])
      co.total.to_f
    end

    def requirement4
      co = initialize_checkout
      co.scan(items[0])
      co.scan(items[2])
      co.scan(items[1])
      co.scan(items[2])
      co.scan(items[2])
      co.total.to_f
    end
  end
end

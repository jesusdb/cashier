# frozen_string_literal: true

module Cashier
  # This class defines the discount to be applied to a product.
  class PricingRule
    attr_reader :name, :discount_percentage, :starting_at_quantity, :item, :greedy

    # Public: Initializes the pricing rule.
    # name                 - The name of the pricing rule.
    # discount_percentage  - Discount in percentage to be applied to the `item`.
    # starting_at_quantity - Defines the starting quantity where the discount will be applied.
    # item                 - The item to which the discount will be applied. It can
    #                        be an instance of Cashier::Item
    def initialize(name, discount_percentage, starting_at_quantity, item, greedy)
      @name = name
      @discount_percentage = BigDecimal(discount_percentage.to_s) / 100.0
      @starting_at_quantity = starting_at_quantity
      @item = item
      @greedy = greedy
    end

    # Public: Gets the discount based on how many items are in the basket.
    # quantity_of_item_in_basket - This quantity is compared with `starting_at_quantity` to
    #                              decide if a discount will be applied or not.
    #
    # Returns the discount of the price of the item multiplied by the `quantity_of_item_in_basket`
    # or the `starting_at_quantity` depending on whether the rule is greedy or not (lazy).
    def discount(quantity_of_item_in_basket)
      return 0 unless quantity_of_item_in_basket >= starting_at_quantity

      discount_percentage * item.price * (greedy ? quantity_of_item_in_basket : starting_at_quantity)
    end
  end
end

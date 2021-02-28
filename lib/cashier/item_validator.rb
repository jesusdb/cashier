# frozen_string_literal: true

module Cashier
  # This module is responsible for validating the item.
  module ItemValidator
    class InvalidItemError < StandardError; end

    def valid_item?(item)
      [validate_code(item), validate_price(item)].none?(false)
    end

    def validate_code!(item)
      raise InvalidItemError, '`item` should respond to `code`' unless item.respond_to?(:code)
    end

    def validate_price!(item)
      raise InvalidItemError, '`item` should respond to `price`' unless item.respond_to?(:price)
    end

    def validate_code(item)
      validate_code!(item)
    rescue InvalidItemError
      false
    end

    def validate_price(item)
      validate_price!(item)
    rescue InvalidItemError
      false
    end
  end
end

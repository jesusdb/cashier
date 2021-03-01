# frozen_string_literal: true

module Cashier
  # This module is responsible for validating the item.
  module ItemValidator
    class InvalidItemError < StandardError; end

    ATTRIBUTES_TO_VALIDATE = %w[code price].freeze

    def valid_item?(item)
      self.class.public_instance_methods.grep(%r{(?!.*!)validate_.+}).map do |method|
        send(method, item)
      end.any?
    end

    ATTRIBUTES_TO_VALIDATE.map do |attribute|
      define_method "validate_presence_of_#{attribute}!" do |item|
        item.respond_to?(attribute) ? true : raise(InvalidItemError, "`item` should respond to #{attribute}")
      end

      define_method "validate_presence_of_#{attribute}" do |item|
        send("validate_presence_of_#{attribute}!", item)
      rescue InvalidItemError
        false
      end
    end
  end
end

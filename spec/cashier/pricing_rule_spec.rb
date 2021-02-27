# frozen_string_literal: true

RSpec.describe Cashier::PricingRule do
  subject(:pricing_rule) { described_class.new(name, discount_percentage, starting_at_quantity, item, greedy) }

  let(:name) { 'An amazing discount!' }
  let(:discount_percentage) { BigDecimal('50.0') }
  let(:starting_at_quantity) { 4 }
  let(:item) { double('item', price: BigDecimal('10.0')) }
  let(:greedy) { false }
  let(:item_discount) { item.price * discount_percentage / 100.0 }
  let(:lazy_result)   { item_discount * starting_at_quantity }
  let(:greedy_result) { item_discount * quantity_of_item_in_basket }

  describe 'discount' do
    subject(:discount) { pricing_rule.discount(quantity_of_item_in_basket) }

    context 'when the quantity of item in basket is more than the quantity to reach the discount' do
      context 'and the pricing rule is wanted to be applied as many times as the condition applies' do
        let(:greedy) { true }

        context 'and the quantity to reach the discount is the same than the quantity of item in basket' do
          let(:quantity_of_item_in_basket) { starting_at_quantity }

          it { is_expected.to eq lazy_result   }
          it { is_expected.to eq greedy_result }
        end

        context 'and the quantity of item in basket is less than double of the quantity to reach the discount' do
          let(:quantity_of_item_in_basket) { starting_at_quantity * 2 - 1 }

          it { is_expected.to eq greedy_result }
        end

        context 'and the quantity of item in basket matches the quantity to reach the discount multiple times' do
          let(:quantity_of_item_in_basket) { starting_at_quantity * rand(2..100) }

          it { is_expected.to eq greedy_result }
          it { is_expected.to(satisfy { |result| item.price * quantity_of_item_in_basket % result == 0 }) }
        end
      end

      context 'and the pricing rule is wanted to be applied only once (when the condition matches)' do
        let(:greedy) { false }

        context 'and the quantity of item in basket is less than double of the quantity to reach the discount' do
          let(:quantity_of_item_in_basket) { starting_at_quantity * 2 - 1 }

          it { is_expected.to eq lazy_result }
        end

        context 'and the quantity of item in basket matches the quantity to reach the discount multiple times' do
          let(:quantity_of_item_in_basket) { starting_at_quantity * rand(2..100) }

          it { is_expected.to eq lazy_result }
          it { is_expected.to(satisfy { |result| item.price * starting_at_quantity % result == 0 }) }
        end
      end
    end
  end
end

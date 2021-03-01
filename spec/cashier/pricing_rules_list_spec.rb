# frozen_string_literal: true

RSpec.describe Cashier::PricingRulesList do
  subject(:pricing_rules_list) { described_class.new(*pricing_rules) }

  let(:code1) { 'GR1' }
  let(:code2) { 'SR1' }
  let(:item1) { double('item 1', code: code1) }
  let(:item2) { double('item 2', code: code2) }
  let(:pricing_rule1) { double('a pricing rule', item: item1) }
  let(:pricing_rule2) { double('another pricing rule', item: item2) }
  let(:pricing_rules) { [pricing_rule1, pricing_rule2] }
  let(:discount1) { 5.0 }
  let(:discount2) { 10.0 }

  describe '#discounts' do
    before do
      allow(pricing_rule1).to receive(:discount).and_return discount1
      allow(pricing_rule2).to receive(:discount).and_return discount2
    end

    subject(:total_discounts) { pricing_rules_list.discounts(basket) }

    let(:items) { { code1 => 2, code2 => 1 } }
    let(:basket) { double('basket', items: items) }
    let(:total_discount) { discount1 + discount2 }

    it { is_expected.to eq total_discount }
  end
end

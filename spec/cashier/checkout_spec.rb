# frozen_string_literal: false

RSpec.describe Cashier::Checkout do
  subject(:checkout) { described_class.new(pricing_rules, basket) }

  let(:pricing_rules) { 'pricing_rules' }
  let(:basket) { double('basket', total_price: 10.0) }

  describe '#scan' do
    after { checkout.scan(item) }

    let(:item) { 'item' }

    it { expect(basket).to receive(:add_item).with(item) }
  end

  describe '#total' do
    before { allow(pricing_rules).to receive(:discounts).and_return(half_price) }

    subject(:total) { checkout.total }
    let(:half_price) { basket.total_price / 2 }

    it { is_expected.to eq half_price }
  end
end

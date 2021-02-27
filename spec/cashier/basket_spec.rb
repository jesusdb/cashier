# frozen_string_literal: true

RSpec.describe Cashier::Basket do
  subject(:basket) { described_class.new }

  it { expect(basket.items).to eq({}) }
  it { expect(basket.total_price).to eq 0 }

  describe '#add_item' do
    before { basket.add_item(item1) }

    let(:code1)  { 'GR1' }
    let(:price1) { 5.0 }
    let(:item1)  { double('item 1', code: code1, price: price1) }
    let(:items1) { { code1 => 1 } }

    context 'when only 1 item is added' do
      it { expect(basket.items).to eq items1 }
      it { expect(basket.total_price).to eq price1 }
    end

    context 'when 2 or more items are added' do
      before { 2.times { basket.add_item(item2) } }

      let(:code2)  { 'SR1' }
      let(:price2) { 10.0 }
      let(:item2)  { double('item 2', code: code2, price: price2) }
      let(:items2) { items1.merge({ code2 => 2 }) }
      let(:total_price) { price1 + price2 * 2 }

      it { expect(basket.items).to eq items2 }
      it { expect(basket.total_price).to eq total_price }
    end
  end
end

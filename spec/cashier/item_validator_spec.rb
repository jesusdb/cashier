# frozen_string_literal: true

RSpec.describe Cashier::ItemValidator do
  subject(:item_validator) { Object.include described_class }

  describe '#valid_item?' do
    let(:item) { double('item', code: 'GR1', price: '10.00') }

    context 'when the item is valid' do
      subject(:validated_item) { item_validator.valid_item?(item) }

      it { is_expected.to be true }
    end

    context 'when the item is invalid' do
      subject(:validated_item) { item_validator.valid_item?(invalid_item) }

      described_class::ATTRIBUTES_TO_VALIDATE.map do |attribute|
        context "because the #{attribute} is not present" do
          let(:invalid_item) { item.tap { |i| i.unstub(attribute) } }

          it { is_expected.to be false }
        end
      end
    end
  end
end

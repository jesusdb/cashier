# frozen_string_literal: true

RSpec.describe Cashier::ItemValidator do
  subject(:item_validator) { Object.include described_class }

  let(:valid_item) { double('item', code: 'GR1', price: '10.00') }

  shared_context 'because the attribute is not present' do |attribute|
    let(:invalid_item) { valid_item.tap { |i| i.unstub(attribute) } }

    it { is_expected.to be false }
  end

  describe '#valid_item?' do
    context 'when the item is valid' do
      subject(:result_of_validation) { item_validator.valid_item?(valid_item) }

      it { is_expected.to be true }
    end

    context 'when the item is invalid' do
      subject(:result_of_validation) { item_validator.valid_item?(invalid_item) }

      described_class::ATTRIBUTES_TO_VALIDATE.map do |attribute|
        include_context 'because the attribute is not present', attribute
      end
    end
  end

  described_class::ATTRIBUTES_TO_VALIDATE.map do |attribute|
    describe "#validate_presence_of_#{attribute}!" do
      context 'when the item is valid' do
        subject(:result_of_validation) { send("validate_presence_of_#{attribute}!", valid_item) }

        it { is_expected.to be true }
      end

      context 'when the item is invalid' do
        subject(:result_of_validation) { send("validate_presence_of_#{attribute}!", invalid_item) }

        let(:invalid_item) { valid_item.tap { |i| i.unstub(attribute) } }

        it { expect { result_of_validation }.to raise_error(InvalidItemError) }
      end
    end

    describe "#validate_presence_of_#{attribute}" do
      context 'when the item is valid' do
        subject(:result_of_validation) { send("validate_presence_of_#{attribute}", valid_item) }

        it { is_expected.to be true }
      end

      context 'when the item is invalid' do
        subject(:result_of_validation) { send("validate_presence_of_#{attribute}", invalid_item) }

        include_context 'because the attribute is not present', attribute
      end
    end
  end
end

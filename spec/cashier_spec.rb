# frozen_string_literal: true

RSpec.describe Cashier do
  it 'has a version number' do
    expect(Cashier::VERSION).not_to be nil
  end
end

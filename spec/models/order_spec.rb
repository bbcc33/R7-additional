require 'rails_helper'

RSpec.describe Order, type: :model do
  # let(:customer) { FactoryBot.create(:customer) }
  # subject { Order.new(product_name: 'Cinnamon', product_count: 3, customer:) }
  subject { Order.new(product_name: 'gears', product_count: 7, customer: FactoryBot.create(:customer)) }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a product_name' do
    subject.product_name = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a product_count' do
    subject.product_count = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a customer' do
    subject.customer = nil
    expect(subject).to_not be_valid
  end
end

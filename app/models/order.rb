class Order < ApplicationRecord
  belongs_to :customer # sets up the association between orders and customer so automatically validates that a customer is present

  validates :product_name, presence: true, format: { with: /\A[a-z\-' ]+\z/i }
  validates :product_count, presence: true, numericality: { only_integer: true }
  validates :customer, presence: true
end

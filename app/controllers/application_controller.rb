class ApplicationController < ActionController::Base
  # need this b/c my orders and customers were not global variables before
  before_action :set_orders
  before_action :set_customers
  # before_action :set_customer, only: %i[show edit update destroy]

  private

  def set_orders
    @orders = Order.all
  end

  def set_customers
    @customers = Customer.all
  end
end

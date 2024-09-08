class OrdersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :catch_not_found
  before_action :set_order, only: %i[show edit update destroy]

  def index
    @orders = Order.all
  end

  def show
  end

  def edit
    @order = Order.find(params[:id])
  end

  def new
    @order = Order.new
  end

  def create
    # @order = Order.new(product_name: '...', product_count: '...') # no filtering and security checks this way
    @order = Order.new(order_params)
    if @order.save
      flash[:notice] = 'The order was created successfully'
      redirect_to @order
      # render :new
    else
      flash[:alert] = 'Failed to create a new order'
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @order.update(order_params)
      flash[:notice] = 'The order was updated successfully.'
      redirect_to @order
    else
      flash[:alert] = 'Failed to update order'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @order.destroy

    respond_to do |format|
      flash[:notice] = 'The order was successfully deleted'
      format.html { redirect_to orders_url }
      format.json { head :no_content }
    end
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :product_name, :product_count)
  end

  def set_order
    @order = Order.find(params[:id])
  end

  def catch_not_found(e)
    Rails.logger.debug('We had a not found exception.')
    flash.alert = e.to_s
    redirect_to orders_path
  end
end

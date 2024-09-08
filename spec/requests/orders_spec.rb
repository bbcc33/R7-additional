require 'rails_helper'

RSpec.describe 'Orders', type: :request do
  let(:customer) { FactoryBot.create(:customer) }

  describe 'GET /index' do
    it 'renders the index view' do
      FactoryBot.create_list(:order, 4, customer:)
      get orders_path
      expect(response).to render_template(:index)
    end
  end

  describe 'get order_path' do
    it 'renders the :show template' do
      order = FactoryBot.create(:order, customer:)
      get order_path(order)
      expect(response).to render_template(:show)
    end
    it 'redirects to the index path if the order id is invalid' do
      get order_path(id: 5000) # an ID that doesn't exist
      expect(response).to redirect_to orders_path
    end
  end

  describe 'get new_order_path' do
    it 'renders the :new template' do
      get new_order_path
      expect(response).to render_template(:new)
    end
  end

  describe 'get edit_order_path' do
    it 'renders the :edit template' do
      order = FactoryBot.create(:order, customer:)
      get edit_order_path(order)
      expect(response).to render_template(:edit)
    end
  end

  describe 'post orders_path with valid data' do
    it 'saves a new entry and redirects to the show path for the entry' do
      customer = FactoryBot.create(:customer)
      order_attributes = FactoryBot.attributes_for(:order, customer_id: customer.id)
      expect do
        post orders_path, params: { order: order_attributes }
      end.to change(Order, :count).by(1)
      expect(response).to redirect_to order_path(Order.last)
    end
  end

  describe 'post orders_path with invalid data' do
    it 'does not save a new entry or redirect' do
      order_attributes = FactoryBot.attributes_for(:order).merge(customer_id: customer.id)
      order_attributes[:product_name] = nil
      expect do
        post orders_path, params: { order: order_attributes }
      end.to_not change(Order, :count)
      expect(response).to render_template(:new)
    end
  end

  describe 'delete a order record' do
    it 'deletes a order record' do
      order = FactoryBot.create(:order, customer:)
      expect do
        delete order_path(order)
      end.to change(Order, :count).by(-1)
      expect(response).to redirect_to(orders_path)
    end
  end

  describe 'put order_path with valid data' do
    it 'updates an entry and redirects to the show path for the order' do
      order = FactoryBot.create(:order, customer:)
      put order_path(order), params: { order: { product_name: 'test' } }
      order.reload
      expect(order.product_name).to eq('test')
      expect(response).to redirect_to(order_path(order))
    end
  end

  describe 'put order_path with invalid data' do
    it 'does not update the order record or redirect' do
      order = FactoryBot.create(:order, customer:)
      put order_path(order.id), params: { order: { product_count: 'abc' } }
      order.reload
      expect(order.product_count).not_to eq('abc')
      expect(response).to render_template(:edit)
    end
  end
end

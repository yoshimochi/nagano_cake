class Public::OrdersController < ApplicationController
  # def new
  #   @order = Order.new
  # end

  def new
    @order = Order.new
  end

  def confirm
    @order = Order.new(order_params)
    @cart_items = current_customer.cart_items

    if params[:order][:delivery_address] == "customer_address"
      @order.delivery_postal_code = current_customer.postal_code
      @order.delivery_address = current_customer.address
      @order.delivery_name = current_customer.last_name + current_customer.first_name
    elsif params[:order][:delivery_address] == "delivery_address"
      @order.delivery_postal_code = current_customer.postal_code
      @order.delivery_address = current_customer.address
      @order.delivery_name = current_customer.name
    elsif params[:order][:delivery_address] == "new_delivery_address"
      @delivery = Delivery.new
      @order.delivery_postal_code = params[:order][:postal_code]
      @order.delivery_address  = params[:order][:address]
      @order.delivery_name     = params[:order][:name]
      # # 住所の保存
      # @delivery.customer_id = current_customer.id
      # @delivery.postal_code = @order.delivery_postal_code
      # @delivery.address = @order.delivery_address
      # @delivery.name = @order.delivery_name
      # @delivery.save
    end
  end

  def create
    @order = current_customer.orders.new(order_params)
    @order.save
    @cart_items = current_customer.cart_items.all

    @cart_items.each do |cart_item|
      @order_items = @order.order_items.new
      @order_items.item_id = cart_item.item_id
      @order_items.price = cart_item.price
      @order_items.amount = cart_item
      @order_items.save
    end

  end

  def index
  end

  def show
  end

  private
  def order_params
    params.require(:order).permit(
      :customer_id, :delivery_postal_code, :delivery_address, :delivery_name,
      :delivery_cost, :change, :payment_method, :status
    )
  end
end

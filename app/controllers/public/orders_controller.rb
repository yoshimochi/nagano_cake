class Public::OrdersController < ApplicationController
  include ApplicationHelper

  def new
    # @customer = current_customer
    @order = Order.new
    # @addresses = Address.where(customer: current_customer)
  end


  def confirm
    @cart_items = current_customer.cart_items
    @order = Order.new
    @order.customer_id = current_customer.id
    @order.payment_method = params[:order][:payment_method]

    if params[:order][:current_customer] == "customer_address"
      @order.delivery_postal_code = current_customer.postal_code
      @order.delivery_address = current_customer.address
      @order.delivery_name = current_customer.last_name + current_customer.first_name
    elsif params[:order][:current_customer] == "delivery_address"
      address = Address.find(params[:order][:address_id])
      @order.delivery_postal_code = postal_code
      @order.delivery_address = address
      @order.delivery_name = name
    elsif params[:order][:current_customer] == "new_delivery_address"
      @order.delivery_postal_code = params[:order][:postal_code]
      @order.delivery_address = params[:order][:address]
      @order.delivery_name = params[:order][:name]
      @delivery = "1"
    else
      @order = Order.new
      render :new
    end
  end

  def create
    @order = Order.new(order_params)
    @order.save
    redirect_to thanks_orders_path

    if params[:order][:current_customer] == "1"
      current_customer.addresses.create(address_params)
    end

     @cart_items = current_customer.cart_items
     @cart_items.each do |cart|
      OrderProduct.create(
        item: cart.item,
        order: @order,
        amount: cart.amount,
        total_price: cart.item.price
        )
     end
     @cart_items.destroy_all
  end

  def index
    @orders = current_customer.orders.all
  end

  def show
    @order = Order.find(params[:id])
    @order_products = @order.order_products
    @orders = current_customer.orders
  end

  private
  def order_params
    params.require(:order).permit(
      :customer_id, :delivery_postal_code, :delivery_address, :delivery_name,
      :delivery_cost, :charge, :payment_method, :status, :tax_price
    )
  end

  def address_params
    params.require(:order).permit(:name, :postal_code, :address)
  end
end

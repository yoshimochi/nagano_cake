class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @customer = current_customer
  end

  def confirm
    @cart_items = current_customer.cart_items
    @order = Order.new(order_params)
    render :new if @order.invalid?
  end

  def create
    @order = Order.new(order_params)
    render :new and return if params[:back] || !@order.save
    redirect_to @order
  end

  def index
  end

  def show
  end

  private
  def order_params
    params.require(:order).permit(:delivery_postal_code, :delivery_address, :delivery_name)
  end
end

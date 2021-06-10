class Public::OrdersController < ApplicationController

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
      @address = Address.new
      @address.name = params[:order][:name]
      @address.postcode = params[:order][:postal_code]
      @address.address = params[:order][:address]
      @address.customer_id = current_customer.id
      @address.save!
      @order.delivery_postal_code = @address.postal_code
      @order.delivery_address = @address.address
      @order.delivery_name = @address.name
    else
      @order = Order.new
      render :new
    end
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
   if @order.save
     @carts = current_customer.cart_items
     @carts.each do |cart|
       order_item = OrderItem.new(order_id: @order.id)
       order_item.price = cart.price
       order_item.amount = cart.amount
       order_item.item_id = cart.item_id
       order_item.save!
     end
     @carts.destroy_all
     redirect_to thanks_orders_path
   else
      @order = Order.new
      render :new
   end

  end

  #   @cart_items.each do |cart_item|
  #     @order_items = @order.order_items.new
  #     @order_items.item_id = cart_item.item_id
  #     @order_items.price = cart_item.price
  #     @order_items.amount = cart_item.amount
  #     @order_items.save
  #   end
  #   @cart_items.destroy_all
  #   redirect_to thanks_orders_path

  # end

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
  end

  private
  def order_params
    params.require(:order).permit(
      :customer_id, :delivery_postal_code, :delivery_address, :delivery_name,
      :delivery_cost, :charge, :payment_method, :status, :tax_price
    )
  end

  # def address_params
  #   params.require(:order).permit(:name, :postal_code, :address)
  # end
end

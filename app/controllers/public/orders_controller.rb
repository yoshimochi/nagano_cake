class Public::OrdersController < ApplicationController
  include ApplicationHelper

  before_action :authenticate_customer!

  def new
    @order = Order.new
    @addresses = Address.where(customer: current_customer)
  end

  def confirm
    @cart_items = current_customer.cart_items
    @order = Order.new

    if params[:order][:current_customer] == "customer_address"
      @order.delivery_postal_code = current_customer.postal_code
      @order.delivery_address = current_customer.address
      @order.delivery_name = current_customer.last_name + current_customer.first_name

    elsif params[:order][:current_customer] == "delivery_address"
      address = Address.find(params[:order][:address_id])
      @order.delivery_postal_code = address.postal_code
      @order.delivery_address = address.address
      @order.delivery_name = address.name

    elsif params[:order][:current_customer] == "new_delivery_address"
      if params[:order][:delivery_postal_code] != "" && params[:order][:delivery_address] != "" && params[:order][:delivery_name] != ""
        @order.delivery_postal_code = params[:order][:delivery_postal_code]
        @order.delivery_address = params[:order][:delivery_address]
        @order.delivery_name = params[:order][:delivery_name]
        @address = "1"
      else
        flash[:danger] = "新しいお届け先が入力されていません"
        redirect_to new_order_path
      end
    end
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.status = 0

    if @order.save
      flash[:success] = "ご注文が確定しました。"
      current_customer.cart_items.each do |cart_item|
        @order_product = OrderProduct.new
        @order_product.order_id = @order.id
        @order_product.item_id = cart_item.item_id
        @order_product.amount = cart_item.amount
        @order_product.tax_included = tax_price(cart_item.item.price)
        @order_product.total_price = tax_price(cart_item.item.price) * cart_item.amount
        @order_product.save
      end

      if params[:order][:address] == "1"
        current_customer.addresses.create(address_params)
      end

      current_customer.cart_items.destroy_all
      redirect_to thanks_orders_path
    else
      @order = Order.new
      @addresses = current_customer.addresses
      render :new
    end
  end


  def index
    @orders = current_customer.orders.page(params[:page]).reverse_order
    # @orders = Order.where(customer_id: current_customer.id).order("created_at DESC")
  end

  def show
    @order = Order.find(params[:id])
    @order_products = @order.order_products
  end

  def destroy
    order = Order.find(params[:id])
    order.destroy
    redirect_to orders_path
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

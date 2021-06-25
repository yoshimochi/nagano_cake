class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @order = Order.find(params[:id])
    @customer=Customer.find_by(id: @order.customer_id)
    @order_products = OrderProduct.where(order_id: @order.id)
  end

  def update
    @order = Order.find(params[:id])
    @order_products = OrderProduct.where(order_id: @order.id)

    @order.update(order_params)

      if  @order.status == "入金確認"
        @order_products.update(making_status: 1)
      end

   redirect_to admin_order_path(@order.id)

  end

  private
  def order_params
    params.require(:order).permit(:status)
  end
end

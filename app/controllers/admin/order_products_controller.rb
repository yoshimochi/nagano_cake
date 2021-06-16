class Admin::OrderProductsController < ApplicationController
  before_action :authenticate_admin!

  def update
    @order_product = OrderProduct.find(params[:id])
    @order = Order.find(params[:order_id])
    # @order_product.update(order_product_params)
      if params[:making_status] == "製作中"
        @order.update(status: 2)
      elsif params[:making_status] == "製作完了"
        @order.update(status: 3)
      end

    redirect_to admin_root_path(@order_product.order)
  end

  # private

  # def order_product_params
  #   params.permit(:making_status)
  # end

end

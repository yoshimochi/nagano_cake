class Admin::OrderProductsController < ApplicationController
  before_action :authenticate_admin!

  def update
    @order_product = OrderProduct.find(params[:id])
    @order = @order_product.order
    @order_product.update(order_product_params)
      if params[:making_status] == "製作中"
        @order = @order_product.order
        @order.update(status: 2)
      elsif @order.order_products.where(making_status: "製作完了").count == @order.order_products.count
        @order = @order_product.order
        @order.update(status: 3)
      end

    redirect_to admin_root_path(@order_product.order)
  end

  private

  def order_product_params
    params.require(:order_product).permit(:making_status)
  end

end

class Public::CartItemsController < ApplicationController
  # before_action :authenticate_custmor!
  before_action :setup_cart_item!, only: [:create, :update, :destroy]

  def create
    @cart_item = current_customer.cart_items.new(item_id: params[:item_id])
    @cart_item.amount = params[:amount].to_i
    @cart_item.save
    redirect_to cart_items_path
  end

  def index
    @cart_items = current_customer.cart_items
    @items = Item.all
  end

  def update
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    @cart_items = current_customer.cart_items.all
    @cart_items.destroy_all
    redirect_to cart_items_path
  end

  private
  # def cart_item_params
  #   params.require(:cart_item).permit(:amount, :item_id, :customer_id)
  # end

  def setup_cart_item!
    @cart_item = current_customer.cart_items.find_by(item_id: params[:item_id])
  end

end

class Public::CartItemsController < ApplicationController
  # before_action :authenticate_custmor!
  # before_action :setup_cart_item!, only: [:create, :update, :destroy]
  def index
    @cart_items = current_customer.cart_items
    @numbers = (1..20).to_a
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(amount: params[:amount].to_i)
    flash[:notice] = "#{@cart_item.item.name}の数量を変更しました。"
    redirect_to cart_items_path
  end

  def create
    @cart_item = current_customer.cart_items.new(cart_item_params)
    @update_cart_item = CartItem.find_by(item: @cart_item.item)
    if @update_cart_item.present? && @cart_item.valid?
      @cart_item.amount += @update_cart_item.amount
      @update_cart_item.destroy
    end
    if @cart_item.save
      flash[:notice] = "#{@cart_item.item.name}をカートに追加しました。"
      redirect_to cart_items_path
    else
      @item = Item.find(params[:cart_item][:item_id])
      @cart_item = CartItem.new
      flash[:alert] = "個数を選択してください。"
      render "items/show"
    end
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    @cart_items = current_customer.cart_items
    @cart_items.destroy_all
    redirect_to cart_items_path
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:amount,:item_id)
  end


end
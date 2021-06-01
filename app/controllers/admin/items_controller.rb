class Admin::ItemsController < ApplicationController
  def index
    @items = Item.all.order(created_at: :asc).page(params[:page]).per(10)
  end

  def new
    @item = Item.new
  end

  def create
    item = Item.new(item_params)
    item.save
    redirect_to '/admin/items'
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    @item.update(item_params)
    redirect_to '/admin/items'
  end

  private

  def item_params
    params.require(:item).permit(:genre_id, :name, :image_id, :introduction, :price, :is_active, :image)
  end

end

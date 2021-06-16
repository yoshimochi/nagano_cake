class Public::HomesController < ApplicationController
  def top
    @items = Item.all.order(created_at: :asc).page(params[:page]).per(8)
  end

  def about
  end
end

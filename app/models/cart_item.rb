class CartItem < ApplicationRecord
  belongs_to :item
  belongs_to :customer

  def add_tax_price
    (self.price * 1.10).round
  end

  def sub_total
    cart_item.item.add_tax_price.to_i  *  cart_item.amount
  end

end

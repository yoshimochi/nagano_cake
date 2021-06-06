class Item < ApplicationRecord
  belongs_to :genre
  has_many :cart_items
  has_many :order_products

  attachment :image

  validates :is_active, inclusion: { in: [true, false]}

  def add_tax_price
    (self.price * 1.10).round
  end

  def sub_total
    cart_item.item.add_tax_price.to_i  *  cart_item.amount
  end

end

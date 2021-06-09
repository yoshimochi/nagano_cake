module ApplicationHelper

  # 税込
  def tax_price(price)
    (price * 1.10).floor
  end

  # 小計
  def sub_price(sub)
    (tax_price(sub.item.price) * sub.amount)
  end

  # 合計
  def total_price(totals)
    price = 0
    totals.each do |total|
      price += sub_price(total)
    end
    return price
  end

  def charge(order)
    total_price(current_customer.cart_items) + order.delivery_cost
  end

  def current_cart
    @cart_items = current_customer.cart_items
  end

end

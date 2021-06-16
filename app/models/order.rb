class Order < ApplicationRecord
  has_many :order_products, dependent: :destroy
  belongs_to :customer

  def sum_order_products
    self.order_products.all.sum(:amount)
  end

  #注文の合計金額
  def total_price
    array = []
    self.order_products.each do |order_product|
      array << order_product.tax_included * order_product.amount
  end
    array.sum
  end

  enum payment_method: {"クレジットカード": 0, "銀行振込": 1 }
  enum status: {"入金待ち": 0, "入金確認": 1, "製作中": 2, "発送準備": 3, "発送済み": 4}

end

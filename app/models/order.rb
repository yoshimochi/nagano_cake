class Order < ApplicationRecord
  has_many :order_products
  belongs_to :customer

  enum payment_method: {"クレジットカード": 0, "銀行振込": 1 }
  enum status: {"入金待ち": 0, "入金確認": 1, "制作中": 2, "発送準備": 3, "発送済み": 4}

  validates :customer_id, presence: true
end

class OrderProduct < ApplicationRecord
  belongs_to :item
  belongs_to :order

  enum order_products: {"製作不可": 0, "製作待ち": 1, "制作中": 2, "製作完了": 3}
end

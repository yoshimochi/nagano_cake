class Item < ApplicationRecord
  belongs_to :genre
  attachment :image

  validates :is_active, inclusion: { in: [true, false]}

  def add_tax_price
    (self.price * 1.08).round
  end

end

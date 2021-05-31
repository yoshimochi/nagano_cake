class Item < ApplicationRecord
  attachment :image

  belongs_to :genre

  validates :is_active, inclusion: { in: [true, false]}

end

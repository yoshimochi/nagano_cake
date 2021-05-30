class Item < ApplicationRecord
  attachment :image
  
  has_many :genres
end

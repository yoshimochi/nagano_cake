class Customer < ApplicationRecord
  has_many :addresses
  has_many :cart_items
  has_many :orders
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  validates :is_active, inclusion: { in: [true, false]}

end

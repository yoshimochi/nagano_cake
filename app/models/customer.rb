class Customer < ApplicationRecord
  has_many :addresses, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_many :orders, dependent: :destroy
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  validates :is_active, inclusion: { in: [true, false]}

end

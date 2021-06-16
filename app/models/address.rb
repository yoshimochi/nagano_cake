class Address < ApplicationRecord
  belongs_to :customer

  validates :postcode, presence: true, numericality: { only_integer: true }, length: { is: 7 }
  validates :address, presence: true
  validates :destination, presence: true

  def order_address
	self.postal_code + self.address + self.name
  end
end

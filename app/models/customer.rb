class Customer < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :addresses, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_many :orders, dependent: :destroy


  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true, format: {with: /\A[ァ-ヶー－]+\z/}
  validates :first_name_kana, presence: true, format: {with: /\A[ァ-ヶー－]+\z/}
  validates :postal_code, presence: true, format: {with: /\A\d{7}\z/}
  validates :address, presence: true
  validates :telephone_number, presence: true, format: {with: /\A\d{10,11}\z/}
  validates :is_active, inclusion: {in: [true, false]}


  def active_for_authentication?
    super && (is_active == false)
  end

  def name
    last_name + first_name
  end

end

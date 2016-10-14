class Order < ApplicationRecord
  has_many :purchases, dependent: :destroy
  has_many :products, through: :purchases
end

class Purchase < ApplicationRecord
  belongs_to :product
  belongs_to :order

  has_many :shipments, dependent: :destroy
end

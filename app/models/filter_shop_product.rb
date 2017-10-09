class FilterShopProduct < ApplicationRecord
  belongs_to :shop
  validates :product_id, uniqueness: true
end

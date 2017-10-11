class FilterShopProduct < ApplicationRecord
  belongs_to :shop
  has_many :funnel_products, dependent: :destroy # funnel products per funnel
  has_many :funnels, through: :funnel_products # funnels related to product
  validates :product_id, uniqueness: true
end

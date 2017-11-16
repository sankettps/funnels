class Funnel < ApplicationRecord
  belongs_to :shop
  has_many :funnel_products, dependent: :destroy # funnel products per funnel
  has_many :filter_shop_product, through: :funnel_products # products per funnel

  # has_many :upsell_products, dependent: :destroy # funnel products per funnel
  # has_many :filter_shop_product, through: :upsell_products # products per funnel

  # has_many :downsell_products, dependent: :destroy # funnel products per funnel
  # has_many :filter_shop_product, through: :downsell_products # products per funnel
end

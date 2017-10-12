class Funnel < ApplicationRecord
  belongs_to :shop
  belongs_to :up_product, :class_name => 'FilterShopProduct'
  belongs_to :down_product, :class_name => 'FilterShopProduct'
  has_many :funnel_products, dependent: :destroy # funnel products per funnel
  has_many :filter_shop_product, through: :funnel_products # products per funnel
end

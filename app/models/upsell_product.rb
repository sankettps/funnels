class UpsellProduct < ApplicationRecord
  belongs_to :funnel
  belongs_to :filter_shop_product
end

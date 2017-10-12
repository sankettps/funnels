class FunnelProduct < ApplicationRecord
  belongs_to :filter_shop_product
  belongs_to :funnel
end

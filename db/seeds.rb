# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
@shop = Shop.first
@shop.funnels.create(name: 'test modal',title: 'Entry from seed',up_product_id: FilterShopProduct.first.id,down_product_id: FilterShopProduct.second.id,is_active: true)
@shop.funnels.create(name: 'test modal 1',title: 'Purchase more product',up_product_id: FilterShopProduct.first.id,down_product_id: FilterShopProduct.second.id,is_active: false)

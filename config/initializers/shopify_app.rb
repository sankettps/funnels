ShopifyApp.configure do |config|
  config.application_name = "Hero Funnels App"
  # ==================live========================
  # config.api_key = "60ff38e2475924fba4e5589bc06d0e3c"
  # config.secret = "51f813288b86402879469e22f5381bda"

  # ==================local sank========================
  # config.api_key = "ecd5c0c1818ab329ee117ee64d3f31c9"
  # config.secret = "18ff7a10afa5d2ebf245611e44dd8099"

  # ==================local piyush========================
  # config.api_key = "5aca797625f9a802944fa037f87a13ef"
  # config.secret = "49f8583d94cc7d24baac925f9eea3b15"

  # ==================amazone========================
  config.api_key = "93dd4437ca224158983db75dc8e0d9a3"
  config.secret = "06d8524ce675cff5fca770bcd7c3972e"

  # config.scope = "read_orders, read_products, write_themes"
  config.scope = "read_orders, read_products, read_themes, write_themes, write_script_tags"

  config.embedded_app = false
  config.after_authenticate_job = false
  config.session_repository = Shop
  config.webhooks = [
    {topic: 'orders/create', address:  ENV["hf_domain"]+'/webhooks/orders_create', format: 'json'},
    {topic: 'shop/update', address: ENV["hf_domain"]+'/webhooks/shop_update', format: 'json'},
    {topic: 'app/uninstalled', address: ENV["hf_domain"]+'/webhooks/shop_uninstall', format: 'json'},
    {topic: 'products/update', address: ENV["hf_domain"]+'/webhooks/products_update', format: 'json'},
    {topic: 'products/create', address: ENV["hf_domain"]+'/webhooks/products_create', format: 'json'},
    {topic: 'products/delete', address: ENV["hf_domain"]+'/webhooks/products_delete', format: 'json'},
  ]
end

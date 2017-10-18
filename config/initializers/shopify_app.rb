ShopifyApp.configure do |config|
  config.application_name = "Hero Funnels App"
  # ==================live========================
  config.api_key = "60ff38e2475924fba4e5589bc06d0e3c"
  config.secret = "51f813288b86402879469e22f5381bda"

  # ==================local========================
  # config.api_key = "ecd5c0c1818ab329ee117ee64d3f31c9"
  # config.secret = "18ff7a10afa5d2ebf245611e44dd8099"

  # config.scope = "read_orders, read_products, write_themes"
  config.scope = "read_orders, read_products, read_themes, write_themes, write_script_tags"

  config.embedded_app = true
  config.after_authenticate_job = false
  config.session_repository = Shop
end

ShopifyApp.configure do |config|
  config.application_name = "My Shopify App"
  config.api_key = "60ff38e2475924fba4e5589bc06d0e3c"
  config.secret = "51f813288b86402879469e22f5381bda"
  config.scope = "read_orders, read_products"
  config.embedded_app = true
  config.after_authenticate_job = false
  config.session_repository = Shop
end

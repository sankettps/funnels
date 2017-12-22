Rails.application.routes.draw do
  resources :advance_settings
  get "dashboard/dashboard"
  # root :to => 'home#index'
  root :to => 'dashboard#dashboard'

  get 'funnels/change_status'
  post 'funnels/create'
  post 'funnels/update'
  get 'funnels/design_test'
  get 'funnels/test'
  resources :funnels
  get 'home/test_modal'
  get 'home/contact_us'
  post 'home/contact_us_send_mail'
  
  get "frontend/get_upsell_detail"
  get "frontend/get_downsell_detail"
  get "frontend/test"
  get "frontend/getupsellproduct"
  
  get "frontend/funnel_product_added"
  get "frontend/funnel_product_viewed"

  get "reports/upsell_report"
  get "reports/statistics"
  post "shop/filter_products"
  post "shop/get_all_products"

  # post "frontend/getupsellproduct"
  mount ShopifyApp::Engine, at: '/'
  # match ':controller(/:action(/:id(.:format)))' => 'offers#list', via: [:get, :post]
end

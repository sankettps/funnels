Rails.application.routes.draw do
  # get "dashboard/dashboard"
  # root :to => 'home#index'
  root :to => 'dashboard#dashboard'

  get 'funnels/change_status'
  resources :funnels
  get 'home/test_modal'
  get "frontend/get_upsell_detail"
  get "frontend/test"
  mount ShopifyApp::Engine, at: '/'
  match ':controller(/:action(/:id(.:format)))' => 'offers#list', via: [:get, :post]
end

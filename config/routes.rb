Rails.application.routes.draw do
  get "dashboard/dashboard"
  resources :funnels
  root :to => 'home#index'
  mount ShopifyApp::Engine, at: '/'
  match ':controller(/:action(/:id(.:format)))' => 'offers#list', via: [:get, :post]
end

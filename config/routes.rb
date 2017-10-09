Rails.application.routes.draw do
  root :to => 'home#index'
  mount ShopifyApp::Engine, at: '/'
  match ':controller(/:action(/:id(.:format)))' => 'offers#list', via: [:get, :post]
end

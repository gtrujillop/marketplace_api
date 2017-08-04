Rails.application.routes.draw do
  devise_for :users
  scope module: 'api' do
    namespace :v1 do
      devise_for :users, defaults: { format: :json }, controllers: { sessions: 'api/v1/sessions', registrations: 'api/v1/registrations' }
      resources :products, only: [:create, :index, :show]
      resources :users do
        resources :carts
        resources :orders, except: [:destroy]
      end
    end
  end
end

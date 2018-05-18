Rails.application.routes.draw do
  root to: 'pages#index'
  get '/prices', to: 'pages#prices', as: 'prices'
  get '/join', to: 'pages#join', as: 'join'
  get '/contact', to: 'pages#contact', as: 'contact'
  get '/:token/confirm_email/', :to => "requests#confirm_email", as: 'confirm_email'
  get '/:token/confirm_raise/', :to => "requests#confirm_raise", as: 'confirm_raise'
  get 'errors/not_found'
  get 'errors/internal_server_error'

  match "/404", :to => "errors#not_found", :via => :all
  match "/500", :to => "errors#internal_server_error", :via => :all

  resources :requests, only: [:new, :create]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

Rails.application.routes.draw do
  root to: 'welcome#index'
  get '/prices', to: 'pages#prices', as: 'prices'
  get '/join', to: 'pages#join', as: 'join'
  get '/contact', to: 'pages#contact', as: 'contact'
  get '/:token/confirm_email/', :to => "requests#confirm_email", as: 'confirm_email'
  get '/:token/confirm_raise/', :to => "requests#confirm_raise", as: 'confirm_raise'

  resources :requests, only: [:new, :create]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

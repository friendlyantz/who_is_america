Rails.application.routes.draw do

  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'pages#welcome'

  get 'welcome', to: 'pages#welcome'
  
  get 'home', to: 'pages#home'

  resources :politicians, only: [:index, :show ]
  resources :quotes, only: [:index ]

  get 'contribute', to: 'pages#contribute'

  get 'my_account', to: 'pages#my_account'

end

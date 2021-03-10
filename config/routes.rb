Rails.application.routes.draw do

  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'pages#welcome'

  get 'welcome', to: 'pages#welcome'
  
  get 'home', to: 'pages#home'

  resources :politicians, only: [:index, :show, :new, :create, :edit, :update ]
  resources :quotes, only: [:index, :new, :create, :edit, :update ] do
    resources :votes, only: [:new, :create]
    # get 'votes', to: 'votes#new'#, as: 'quizio'
    # resources :votes, :path => :quotes, :as => :quotes
  end


  get 'contribute', to: 'pages#contribute'

  post 'cast_vote', to: 'pages#cast_vote'

  get 'my_account', to: 'pages#my_account'

  get 'quiz', to: 'pages#quiz'



end

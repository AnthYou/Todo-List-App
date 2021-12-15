Rails.application.routes.draw do
  devise_for :users, :controllers => {:registrations => "registrations", :sessions => "sessions"}
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :todos, only: [:index, :create] do
    patch 'up', to: "todos#up"
    patch 'down', to: "todos#down"
    patch 'check', to: "todos#check"
  end
end

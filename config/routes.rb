GetTickets::Application.routes.draw do

  match 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: [:get, :post]
  match 'signout', to: 'sessions#destroy', as: 'signout', via: [:get, :post]
  get '/login', to: 'pages#login', as: 'login'


  # devise_for :users, controllers: {omniauth_callbacks: "omniauth_callbacks"}

  resources :invites
  resources :users do
    resources :invites, shallow: true
  end

  resources :events do
    resources :invites, shallow: true
    resources :tickets, shallow: true
  end

  get '/about' => "pages#aboutus"
  get '/terms' => "pages#terms"
  get '/privacy' => "pages#privacy"
  get '/support' => "pages#support"
  get '/search' => "events#search"
  resources :pages

  get '/' => "pages#landing"
  get '/campaign' => "pages#campaign"

end

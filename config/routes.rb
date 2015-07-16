GetTickets::Application.routes.draw do
  get '/' => "pages#home"
  match 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: [:get, :post]
  match 'signout', to: 'sessions#destroy', as: 'signout', via: [:get, :post]
  get '/login', to: 'pages#login', as: 'login'


  # devise_for :users, controllers: {omniauth_callbacks: "omniauth_callbacks"}

  resources :invites
  resources :notifications, only: [:update]
  resources :users do
    resources :invites, shallow: true
  end

  resource :event, only: [] do
    get :demo_closed
    get :demo_open
  end

  resources :events do
    resources :invites, shallow: true
    resources :tickets, shallow: true
  end




  resources :media, only: [:create, :destroy]

  get '/about' => "pages#aboutus"
  get '/terms' => "pages#terms"
  get '/privacy' => "pages#privacy"
  get '/support' => "pages#support"
  get '/landing' => "pages#landing", as: :landing

end

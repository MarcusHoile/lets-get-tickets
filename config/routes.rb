GetTickets::Application.routes.draw do



  match 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: [:get, :post]
  match 'signout', to: 'sessions#destroy', as: 'signout', via: [:get, :post]
  get '/login', to: 'pages#login', as: 'login'


  # devise_for :users, controllers: {omniauth_callbacks: "omniauth_callbacks"}

  resources :invites
  resources :friendships
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
  # resources :users do
  #   resources :events, shallow: true
  #   resources :tickets, shallow: true
  # end

  resources :pages

  get '/' => "pages#landing"
  get '/campaign' => "pages#campaign"



  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end

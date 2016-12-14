Rails.application.routes.draw do

  get 'activities/index'

  root 'home#index'
  get 'myprofile', to: 'home#myprofile'
  get 'myaccounts', to: 'home#myaccounts'
  get 'forbidden', to: 'home#forbidden'
  get 'unregistered', to: 'home#unregistered'
  get 'tos', to: 'home#tos'

  devise_for :users, :controllers => { 
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'registrations',
    sessions: 'sessions'
  }
  
  resources :accounts
  resources :transaction_types
  resources :account_types
  resources :account_transactions
  resources :announcements
  resources :activities
  resources :reports do
    collection do
      get 'soa', to: 'reports#summary_of_accounts'
      get 'accd', to: 'reports#account_details'
      get 'accd_get_accounts', to: 'reports#accd_get_accounts'
    end
  end
  #resources :users, only: [:show]
  #get 'profile', to: 'users#show'

  scope "/admin" do
    #resources :users, except: [:show]
    resources :users
    get 'accounts_management', to: 'users#accounts_management'
  end
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

Rails.application.routes.draw do

  root 'home#index'
  get 'home/peeranatdetail' => 'home#peeranatdetail'
  get 'home/sirajdetail' => 'home#sirajdetail'
  get 'home/yeminidetail' => 'home#yeminidetail'

  #User Management
  get 'users' => 'users#index'
  get 'users/directions'=> 'users#directions'
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" ,:registrations => "users/registrations"}, :skip => [:sessions]
  devise_scope :user do
    get "/login" => "devise/sessions#new" , :as => :new_user_session
    post '/login' => 'devise/sessions#create', :as => :user_session
    delete "/logout" => "devise/sessions#destroy", :as => :destroy_user_session
  end
  namespace :users do
    resources :directions, only: [:show, :edit, :update, :destroy]
  end
  get "users/check_email", :controller => "users", :action => "check_email"
 # map.resources :users
  resources :users, only: [:show]


  #Service
  get 'service/' => 'service#index'
  namespace :service do
    resources :directions, only: [:new, :create, :show]
    resources :places, only: [:index, :new, :create, :show]
  end

  match '/search' => 'service#search', via: [:get, :post]
  match 'service/details' => "service#details", via: [:get, :post]
  match '/service/dispaly' => "service#display" , via: [:get, :post]


  #Admin
  ActiveAdmin.routes(self)


  # devise_scope :user do
  #   get 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  # end
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

Poksific::Application.routes.draw do

  resources :users
#get "static_pages/home"
# get "static_pages/about"
#get "static_pages/contact"
#get "static_pages/articles"
# get "static_pages/media"
  root to: 'uploads#index'
  resources :sessions, only: [:new, :create, :destroy]
  resources :uploads


  match '/upload', to: 'uploads#new'
  
  match '/signup', to: 'users#new'
  match '/signin', to: 'sessions#new'
  match '/signout', to: 'sessions#destroy', via: :delete

  match '/stag/:search' ,  to: 'uploads#stag' ,  :as =>'stag'

  match '/about', to: 'static_pages#about'

  #match '/contact', to: 'static_pages#contact'
  match 'post', to: 'uploads#post'
  
  match "/search", to: 'uploads#search'
  
  match "/search/:search" => 'uploads#search', :as => 'search'
  
  match 'contact' => 'contact#new', :as => 'contact', :via => :get

  match 'contact' => 'contact#create', :as => 'contact', :via => :post
  
  match '/media', to: 'uploads#video'
  
  match '/articles', to: 'uploads#article'
  
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end

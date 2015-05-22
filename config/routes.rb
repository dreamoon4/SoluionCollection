Rails.application.routes.draw do
  root 'welcome#index'

  resources :problems
  resources :solutions
  resources :tags

  post 'problems/like/:id' => 'problems#like', as: :problems_like
  post 'problems/dislike/:id' => 'problems#dislike', as: :problems_dislike

  # ajax helpers
  # Search problem
  get 'ajax/problems/search' => 'problems#search', as: :problems_search
  get 'ajax/tags/search' => 'tags#search', as: :tags_search
  get 'ajax/tags/names' => 'tags#names', as: :tags_names

  # Login
  get 'auth/:provider/callback' => 'login#success'
  get 'auth/failure' => 'login#failure'

  # Users
  get 'login' => 'users#login', as: :user_login
  get 'login_done' => 'users#login_done', as: :login_complete
  get 'logout' => 'users#logout', as: :user_logout
  get 'users/:id' => 'users#show'

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

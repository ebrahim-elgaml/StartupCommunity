require 'api_constraints'
Rails.application.routes.draw do
  devise_for :users
  namespace :api, defaults: {format: 'json'} do
    scope module: :v1, constraints: ApiConstraints.new(version: 1,default: true) do 
        get 'users/test'
        post 'users/unfriend'
        get 'user/friends/:user_id' => 'users#getFriends'
        get 'users/getUser/:id' => "users#getUser"
        get 'users/getFollowedStartups/:user_id' => 'users#getFollowedStartups'
        get 'users/index/:id' => 'users#index'
        get 'posts/timeline/:user_id' => 'posts#timeline'
        get 'posts/show_comments/:id' => 'posts#show_comments'
        resources :posts
        resources :comments
        resources :users, except: [:index]
        post 'user_connections/accept'
        post 'user_connections/reject'
        get 'user_connections/index/:user_id' => 'user_connections#index'
        resources :user_connections, except: [:index]
    end
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

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations',
                                    passwords: 'users/passwords', confirmations: 'users/confirmations'  }

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'pages#home'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase
  #
  get "more_info", to: "pages#more_info", as: :more_info
  get "about_us", to: "pages#about_us", as: :about_us
  patch "update_more_info", to: "pages#update_more_info", as: :update_more_info

  # Example resource route (maps HTTP verbs to controller actions automatically):
  resources :products do
    collection do
      get "book_name", as: :book_name
      get "book_links", as: :book_links
      post "create_photo", as: :create_photo
      delete "delete_photo", as: :delete_photo
    end
    member do
      get "upload_photo", as: :upload_photo
      get "edit_photo", as: :edit_photo
      get "photos", as: :photos
    end
  end

  resources :books

  resources :orders, except: [:index] do
    member do
      post "ship", as: :ship
      post "confirm", as: :confirm
    end

    collection do
      post "inspect"
    end
  end

  get "sold_orders", to: "orders#sold_orders"
  get "bought_orders", to: "orders#bought_orders"

  resources :carts, only: [:show]

  resources :line_items

  # get 'timeline' => 'users#timeline', as: :timeline
  get 'bought_books' => 'users#bought_books', as: :bought_books
  get 'selling_books' => 'users#selling_books', as: :selling_books
  get 'sold_books' => 'users#sold_books', as: :sold_books
  get 'setting' => 'users#setting', as: :user_setting
  patch 'users/update_avatar' => 'users#update_avatar', as: :update_avatar
  patch 'users/update_info' => 'users#update_info', as: :update_info

  get 'checkout/:id' => 'orders#checkout', as: :checkout

  post '/search' => 'pages#search', as: :search
  get '/owner/:id' => 'pages#owner', as: :owner


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

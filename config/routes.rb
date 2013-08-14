Ubjective::Application.routes.draw do
  
  resources :authentications

  resources :home
  root to: 'home#index'

  as :user do
    get '/register', to: 'devise/registrations#new', as: :register
    get '/login', to: 'devise/sessions#new', as: :login
    get '/logout', to: 'devise/sessions#destroy', as: :logout
  end

  #devise_for :users, skip: [:sessions]
  #devise_for :users, path_names: {sign_in: "login", sign_out: "logout"}, controllers: {omniauth_callbacks: "authentications", registrations: "registrations"}
  devise_for :users, path_names: {sign_in: "login", sign_out: "logout"},
                   controllers: {omniauth_callbacks: "authentications", registrations: "registrations"}

  as :user do
    get "/login" => 'devise/sessions#new', as: :new_user_session
    post "/login" => 'devise/sessions#create', as: :user_session
    delete "/logout" => 'devise/sessions#destroy', as: :destroy_user_session
  end

  

  scope ":profile_name" do
    resources :tasks do
      resources :objectives do
        collection { post :sort }
      end
    end
  end

#  resources :tasks do
#    collection { get :browse }
#  end

  get '/browse', to: 'tasks#browse'
  match 'tasks/:task_id/objectives/:objective_id/complete' => 'objectives#complete', :as => :complete_objective
  match 'tasks/:task_id/objectives/:objective_id/uncomplete' => 'objectives#uncomplete', :as => :uncomplete_objective
  match 'tasks/:task_id/public' => 'tasks#public', :as => :public_task
  match 'tasks/:task_id/private' => 'tasks#private', :as => :private_task
  match 'tasks/:task_id/clone' => 'tasks#clone', :as => :clone_task
  match 'tasks/:task_id/share' => 'tasks#share_to_facebook', :as => :share_task
  match 'auth/failure', to: redirect('/')
  # match 'tasks/:task_id/objectives/:objective_id/sort' => 'objectives#sort', :as => :sort_task_objectives

  # get '/:id', to: 'profiles#show', as: 'profile'

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
  # root :to => 'home#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end

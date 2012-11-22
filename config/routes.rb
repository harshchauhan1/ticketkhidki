Ticketkhidki::Application.routes.draw do
  
  resources :bookings, :only => [:create, :index]
 # resources :admins
  #get "users/index"
  resources :movie_shows do
    resources :seats, :only => [:index, :create] do
      collection do
        get :confirm_booking, :as => 'seats_confirmation'
      end
    end
  end
  resources :movie_shows do
    collection do
      post :movie_list
    end
  end
  resources :users
  resource :admin, :only => []
  get 'admin/dashboard', :controller => :admin
  
  scope :path => 'admin' do
    get 'change_password', :controller => 'users' ,:as => :admin_change_password
  end
namespace "admin" do
  resources :bookings, :only => [] do
    collection do
      get :log
      get :log_by_user
      get :log_by_movie
    end
  end
  resources :theatres, :except => [:show] do
    collection do
      get :audis
      get :log
    end
  end
  resources :movie_shows, :only => [:new, :create]
  #resources :theateres do
end
 
 # resources :admins do
 #    collection do
 #      post :log_list
 #      post :add_shows 
 #      get :theatre_log
 #      post :create_theatre_log
 #    end
 #  end
  
  controller :users do
    get 'change_password' => :change_password
    post 'change_password' => :save_password
  end
  resources :main
  controller :sessions do
    get 'login' => :new
    post 'login' => :create 
    delete 'logout' => :destroy
  end
  resources :sessions, :only => []
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
  root :to => 'movie_shows#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
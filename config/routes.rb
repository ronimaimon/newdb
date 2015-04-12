Newdb::Application.routes.draw do

  resources :researches
    resources :task_runs, :only => [ :destroy]
  get "task_runs/move"

  get "utils/getvalue" 
  get "utils/tags" => "utils#tags", :as => :tags


  get "report/index"

  post "report/report"
  post "report/subjects"

  get "home/index"

#  match "measures/index/:r_e_id" => :to => "measures#index", :method => "get"
  get "measures/index"  
   

  post "measures/measure"

  get "uploader/index"
  post "uploader/index"

  match "uploader/loading" => 'uploader#loading'
  
  get "simple_measures/index"
  post "simple_measures/index"

  match "simple_measures/loading" => 'simple_measures#loading'
  
  post "uploader/finished"
  get "uploader/finished"

  get "subjects/index"
  get "subjects/summary"
  get "subjects/create_new"
  get 'subjects/subjects-bulk-update' => 'subjects#bulk_update', :as => 'subject_bulk_update'
  post 'subjects/subjects-bulk-update-save' => 'subjects#bulk_update_save', :as => 'subjects_bulk_update_save'

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
  root :to => 'home#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end

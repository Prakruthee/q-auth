QAuth::Application.routes.draw do

  ## ----------
  ## APIs
  ## ----------

  # Login / Logout
  post    '/api/v1/sign_in'  =>  "api/v1/authentications#create",  :as => :api_sign_in
  delete  '/api/v1/sign_out' =>  "api/v1/authentications#destroy", :as => :api_sign_out

  # My Profile
  get    '/api/v1/my_profile'       =>  "api/v1/my_profile#my_profile",   :as => :api_my_profile
  put    '/api/v1/update_profile'   =>  "api/v1/my_profile#update",       :as => :api_update_profile

  # Members API
  get    '/api/v1/members'            =>  "api/v1/members#index",  :as => :api_members
  get    '/api/v1/members/:id'        =>  "api/v1/members#show",   :as => :api_member


  #department API
  get    '/api/v1/departments'            =>  "api/v1/departments#index",  :as => :api_departments
  get    '/api/v1/department/:id'            =>  "api/v1/departments#show",  :as => :api_department

  #Designation API
  get    '/api/v1/designations'            =>  "api/v1/designations#index",  :as => :api_designations
  get    '/api/v1/designation/:id'        =>  "api/v1/designations#show",   :as => :api_designation

  # ------------
  # Public pages
  # ------------

  root :to => 'public/user_sessions#sign_in'

  # Sign In URLs for users
  get     '/sign_in',         to: "public/user_sessions#sign_in",         as:  :user_sign_in
  post    '/create_session',  to: "public/user_sessions#create_session",  as:  :create_user_session

  # Logout Url
  delete  '/sign_out' ,       to: "public/user_sessions#sign_out",        as:  :user_sign_out
  # ------------
  # Admin pages
  # ------------

  namespace :admin do

    resources :users do

      get :change_status, on: :member
      get 'masquerade'
      get 'make_admin', to: "users#make_admin", as:  :make_admin
      get 'make_super_admin', to: "users#make_super_admin",        as:  :make_super_admin
      get 'remove_admin', to: "users#remove_admin",        as:  :remove_admin
      get 'remove_super_admin', to: "users#remove_super_admin",        as:  :remove_super_admin
      put 'update_status/:user_id', to: "users#update_status",   as:  :update_status
    end

    resources :projects do
      get :change_status, on: :member
      resources :roles, :only=>[:new, :create, :destroy]
      resources :project_links
    end

    resources :images do
      collection do
       delete :destroy_pictures
     end
   end
   resources :departments
   resources :designations

 end

  # ------------
  # User pages
  # ------------

  namespace :user do
    get   '/dashboard',         to: "dashboard#index",   as:  :dashboard # Landing page after sign in
    get   '/settings',          to: "settings#index",   as:  :settings
    get   '/profile',           to: "profile#index",   as:  :profile
    get   '/edit',              to: "profile#edit", as: :edit
    put   '/update',              to: "profile#update", as: :update
    get   '/members',           to: "members#index",   as:  :members
    get   '/member/:id',           to: "members#show",   as:  :member
    resources :images do
     collection do
       delete :destroy_pictures
     end
   end
 end

  # User Pages for teams and user profiles
  get   '/team',               to: "user/team#index",   as:  :team
  get   '/profiles/:username',  to: "user/team#show",    as:  :profile

  # API Test Page
  get '/admin/api/documentation', to: "admin/api_doc#index",   as:  :admin_api_doc


end

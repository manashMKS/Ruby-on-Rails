
 

  

  Rails.application.routes.draw do


    mount Rswag::Ui::Engine => '/api-docs'
    mount Rswag::Api::Engine => '/api-docs'

    mount Ckeditor::Engine => '/ckeditor'
   
   get 'login', to: redirect('/auth/google_oauth2')
   get 'login' , to: redirect('/auth/github')
   get 'logout', to: 'sessions#destroy'
   get 'auth/:provider/callback', to: 'users/sessions#create_admin'
   get '/auth/github/callback' , to:'users/sessions#create_admin'
   get '/auth/facebook/callback' , to:'users/sessions#create_admin'
   get 'auth/failure', to: redirect('/')
      get 'password_resets/new'
  get 'password_resets/edit'


   root 'sessions#new'
   resources :account_activations, only: [:edit]
   resources :password_resets,     only: [:new, :create, :edit, :update]



    namespace :api do 
      namespace :v1 do
        resources :sessions do
          collection do
            post :show_all_user 
            post :otp_admin
            post :create_users
            post :user_view
            delete :user_destroy
            post :block
            post :user_role_create
            post :user_role_update
            post :show_role
            delete :role_destroy
            post :content_create
            post :show_content
            delete :content_destroy
            post :create_action
            post :show_menu
            post :permission_management
            post :show_all_permission
            delete :permission_destroy
          end
        end
      end
    end




namespace :admins do 
  resources :admins do
    collection do
      post :user_role_update
      get :dashboard
      get :users
      get :static_content
      post :content_create
      get :show_content
      get :user_view
      get :block
      get :user_destroy
      get :content_destroy
      get :create_user
      post :create_users
      get :user_role
      post :user_role_create
      post :user_permission_create
      get :permission_management
      post :return_actions
      post :save_permission
      get :permission_destroy
      get :role_destroy
      get :menu_destroy
      get :content_edit
      post :content_update
      post :check_action
      post :check_menus_action
      
     end
    end
 resources :sessions do
      collection do
       get :otp
       get :destroy
       post :otp_admin
       get :signout
      end
    end 
end


namespace :users do 
  resources :users do
    collection do 
     get :dashboard
     get :show
     get :destroy
     post :check_email
     get :dashboard
      get :users
      get :static_content
      post :content_create
      get :show_content
      get :user_view
      get :block
      get :user_destroy
      get :content_destroy
      get :create_user
      post :create_users
      get :user_role
      post :user_role_create
      post :user_permission_create
      get :permission_management
      post :return_actions
      post :save_permission
      get :permission_destroy
      get :role_destroy
      get :menu_destroy
      get :content_edit
      post :content_update
      post :check_action
      post :check_menus_action


     end
    end

      resources :sessions do
      collection do
       post :otp
       post :otp_user
       get :destroy
      end
    end
    resources :password_resets do
      collection do
        post :create
        get :new
        get :edit
      end
    end
  end



end
     
   


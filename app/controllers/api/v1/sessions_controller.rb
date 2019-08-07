class Api::V1::SessionsController < ApplicationController
	
	  
    before_action :check_admin, except: [:create, :otp_admin, :destroy]
 
# def new
#   # redirect_to admin_show_path(id: current_user_a.id) 
#    render json:{
#      responseCode: 201,
#      responseMessage: "admin is already logged in"
#    }if logged_in_a? 
# end


def create_users
      @user = User.new(user_params)
      if @user.save!
      render json: {
      responseCode: 201,
      responseMessage: "user created successfully.",
      user: @user
      } 
      else
      render json: {
      responseCode: 422,
      responseMessage: "not created"
      }
      end
end

def create
  # binding.pry
    @admin = Admin.find_by(email: params[:email])
       if @admin && @admin.authenticate(params[:session][:password])
       @admin= Admin.find_by(email: params[:email])
       token= rand 10000000000...50000000000
       @admin.update(token_id: token)
       otp = rand 1000..9999
       @admin.update(onetimepassword: otp)
       # UserMailer.with(admin: $admin).otp_email_admin.deliver_now
       AdminJob.perform_later(@admin)
       render json: {
       responseCode: 201,
       responseMessage: "Otp send successfully."
       } 
       else
       render json: {
       responseCode: 422,
       responseMessage: "wrong email or password."
       }
       end
end


def otp_admin
  # binding.pry
   @admin = Admin.find_by(email: params[:email])
         if @admin && @admin.onetimepassword == params[:session][:onetimepassword].to_i
         session[:admin_id] = @admin.id
         render json:{
         responseCode: 201,
         responseMessage: "OTP matched.",
         token: @admin.token_id
         }   
         else
         render json:{
         responseCode: 422,
         responseMessage: "incorrect otp."
         }     
         end
end


def show_all_user
    @count = User.count
          if @count ==0
          render json: {
          responseCode: 422,
          responseMessage: 'no user avalable'
          }
          else
          @users = User.all
          render json: { 
          responseCode: 201,
          responseMessage: "users display succesfully.",
          user: @users
          }
          end  
end

def destroy
  binding.pry
	@admin = request.headers[:HTTP_AUTH]
  @admin1=Admin.find_by(token_id: request.headers[:HTTP_AUTH])
        if @admin == @admin1.token_id
        @admin1.update(token_id: nil)
        render json:{
    	  esponseCode: 201,
    	  responseMessage: "you logged out successfully"
        }
        else
 	      render json: {
 		    responseCode: 422,
 		    responseMessage: "you have to logged in for this action"
 	      }
        end
end

def user_view
      @user = User.find_by(:email => params[:email])
        if @user == nil
        render json:{
        responseCode: 422,
        responseMessage: 'user is not present',
        }
        else
        render json: {
        responseCode: 202,
        responseMessage: 'user profile',
        user: @user
        }
        end
    
end

def user_destroy
      @user = User.find_by(:email => params[:email])
         if @user == nil
         render json:{
         responseCode: 422,
         responseMessage: 'user is not present',
         }
         elsif  @user.destroy
         render json: {
         responseCode: 201,
         responseMessage: 'user destroy successfully'
         }
         end
end


def block
      @user = User.find_by(email: params[:email])
       if @user ==nil
         render json:{
         responseCode: 423,
         responseMessage: 'user is not present',
         } 
      elsif @user.present?
       if @user.status == false  
          @user.update(status:true)
          session[:user_id] = nil
          render json:{
          responseCode: 201,
          responseMessage: 'user block successfully '
          }
        else
          @user.update(status:false)
          render json:{
          responseCode: 422,
          responseMessage: 'user unblocked '
          }
          
        end
      end
end


def user_role_create
      @role = UserRole.create(name: params[:session][:name])
         render json: {
         responseCode: 201,
         responseMessage: 'role created successfully'
         }
end

def user_role_update
      @user = User.find_by(email: params[:email])
         if @user==nil
         render json: {
         responseCode: 422,
         responseMessage: 'role is not present'
         }
         else
         @user.update(name: params[:name])
         render json: {
         responseCode: 201,
         responseMessage: 'role updated successfully'
         }
        end
end

def show_role
      @count = UserRole.count
         if @count ==0
         render json: {
         responseCode: 422,
         responseMessage: 'no role available'
         }
         else
         @userrole = UserRole.all
         render json: { 
         responseCode: 201,
         responseMessage: "roles display succesfully.",
         user: @userrole
         }
         end 
end

def role_destroy
      @role = UserRole.find_by(name: params[:name])
         if @role ==nil
         render json: {
         responseCode: 422,
         responseMessage: 'this role is not available'
         }
         else
         @role.destroy
         render json: {
         responseCode: 201,
         responseMessage: 'role deleted successfully'
         }
         end
end

def content_create
      @content = StaticContent.create(content_params)
         render json:{
         responseCode: 201,
         responseMessage: 'content created successfully'
         }
end

def content_destroy
      @content = StaticContent.find_by(title: params[:title])
         if @content ==nil
         render json: {
         responseCode: 422,
         responseMessage: 'content is not available'
         }
         else
         @content.destroy
         render json: {
         responseCode: 201,
         responseMessage: 'content deleted successfully'
         }
         end
end

def show_content
      @count = StaticContent.count
         if @count ==0
         render json: {
         responseCode: 422,
         responseMessage: 'no content avalable'
         }
         else
         @content = StaticContent.all
         render json: { 
         responseCode: 201,
         responseMessage: "content display succesfully.",
         content: @content
         }
         end 
end

def show_menu
        @count = Menu.count
         if @count ==0
         render json: {
         responseCode: 422,
         responseMessage: 'menus not available'
         }
         else
         @menu = Menu.all.pluck(:menu)
         render json: { 
         responseCode: 201,
         responseMessage: "menu display succesfully.",
         menu: @menu
         }
         end 
end
def create_action
   binding.pry
      @menu =  Menu.find_by(menu: params[:session][:menu]) 
         if @menu == nil
         render json: {
         responseCode: 422,
         responseMessage: 'please enter valid menu'
         }
         else
         @menu.actions.create(action: params[:session][:action]) 
         render json: {
         responseCode: 201,
         responseMessage: 'action created successfully'
         }
         end
end

def permission_management
      # unless params[:permission][:menus] == ""
      @role = UserRole.find_by(name: params[:role])
        if @role == nil
             render json: {
             responseCode: 422,
             responseMessage: 'invalid role'
             }
        else
             @menu =  Menu.find_by(menu: params[:menu])
             if @menu == nil
             render json:{
             responseCode: 422,
             responseMessage: 'invalid menu' 
             }
             else
               @action = @menu.actions.find_by(action: params[:session][:action])
               if @action==nil
                  render json:{
                  responseCode: 422,
                  responseMessage: 'invalid action' 
                  }
               else  
                  @roles = UserRole.find_by(name: params[:role])
                  a = Menu.find_by(menu:params[:menu])
                  @action = @roles.permissions.create(menu_id:a.id,permission: params[:session][:action])
                  render json: {
                  responseCode: 201,
                  responseMessage: 'permission granted successfully'
                  }
               end
              end 
         end
end

def show_all_permission
     @count = Permission.count
         if @count ==0
         render json: {
         responseCode: 422,
         responseMessage: 'permissions not available'
         }
         else
         @permission = Permission.all
         render json: { 
         responseCode: 201,
         responseMessage: "permission display succesfully.",
         permission: @permission
         }
         end 
end


def permission_destroy
     @permission = Permission.find_by(id: params[:permission_id])
         if @permission==nil
         render json: {
         responseCode: 422,
         responseMessage: 'permission is not available'
         }
         else
         @permission&.destroy
         render json: {
         responseCode: 201,
         responseMessage: 'permission deleted successfully'
         }
         end
end
  
private

def check_admin
     @admin = request.headers[:HTTP_AUTH]
     @admin1=Admin.find_by(token_id: request.headers[:HTTP_AUTH])
     if @admin1 == nil
     render json: {
     responseCode: 423,
     responseMessage: 'you are not admin'
     }
     end
end

def user_params
     params.require(:session).permit(:name , :email , :phone , :password , :password_confirmation,:avatar)
end

def content_params
    params.require(:session).permit(:title,:latest_content,:start_date,:end_date)
end
end

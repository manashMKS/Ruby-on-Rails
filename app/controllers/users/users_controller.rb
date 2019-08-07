

class Users::UsersController < ApplicationController

before_action :require_login, except: [:new , :create ,:check_email ,:return_actions,:check_action]
# before_action :check_permission , except: [:new , :create]
before_action :set_current_ip , except: [:new , :create ]
before_action :status_check, except: [:new , :create ]
layout 'user'


def new
  # binding.pry
@user = User.new

render :layout => false
  end


	def show
  #    # binding.pry
  # @user = current_user 
  #    @contentss = []
  #     StaticContent.all.each do |content|
 
  #           if (content.start_date == nil || content.end_date == nil) || (content&.start_date < DateTime.now  && DateTime.now < content&.end_date)

     
  #               @contentss << content
  #           # else
  #             # latest_content = StaticContent.find_by(:end_date => Time.zone.now < content.end_date)
  #             # content.update(old_content: content.latest_content,latest_content: "")
  #             # latest_content.delete
  #           end
  #         end	 	
  end



	def create
    
  	@user = User.new(user_params)
     if @user.save

     	WelcomeJob.perform_later(@user)
      flash[:notice] = "Sucess"
     redirect_to new_users_session_path 
    else
      redirect_to new_users_user_path
      
    end

		end


def edit
  # binding.pry
  @user = User.find_by(id: params[:id])
end

def update
  # binding.pry
  @user = User.find_by(id: params[:id])
 
  if @user.update(user_params)
    redirect_to dashboard_users_users_path
  else
    render 'users/users/edit'
  end

  end


  def destroy
    # binding.pry
  @user = User.find_by(id: params[:id])
  @user.destroy
 
  redirect_to dashboard_users_users_path
  end



  def check_email
    # binding.pry
    email_found = User.find_by(email: params[:email]) #Whatever your logic is to find duplicate emails
    message = email_found ? "ERROR" : "SUCCESS"
    render json: {message: message}
  end



def create_user
  @user=User.new
   @user = current_user

end

def create_users
@user = User.new(user_params)
     if @user.save
      
     redirect_to  users_users_users_path
    else

      redirect_to create_user_users_users_path
      
    end 
end
 
def users
  if logged_in_a? 
  @user = current_user
  @users = User.all.order("created_at desc").paginate(:page => params[:page], :per_page => 5)

else
redirect_to new_users_session_path
end
end



def dashboard
 if  current_user.status==false
   @user = current_user
   @contentss = []
      StaticContent.all.each do |content|
 
            if (content.start_date == nil || content.end_date == nil) || (content&.start_date < DateTime.now  && DateTime.now < content&.end_date)

     
                @contentss << content
            # else
              # latest_content = StaticContent.find_by(:end_date => Time.zone.now < content.end_date)
              # content.update(old_content: content.latest_content,latest_content: "")
              # latest_content.delete
            end
          end 
          else
          redirect_to new_users_session_path
          flash[:notice] = "You are blocked by admin"
        end
end

def static_content
   @user = current_user
end

def content_create
   @user = current_user
   @content = StaticContent.create(content_params)
   redirect_to show_content_users_users_path
end

def user_view
  @user = current_user
  @user_view = User.find_by(id: params[:id])
end

def show_content

 @user = current_user
@contents = StaticContent.order("created_at desc").paginate(:page => params[:page], :per_page => 5)


end


def user_role_update
# binding.pry
 @user = current_user
unless params[:session][:user_role_id] == ""
@user = User.find_by(id: params[:id])
  @user.update(user_role_id: params[:session][:user_role_id])
  redirect_to users_users_users_path(current_user)
end
end


def user_role
 @user = current_user

end

def user_role_create
  # binding.pry
 @user = current_user

  @role = UserRole.create(name: params[:session][:name]) unless params[:session][:name]==""
  @menu = Menu.create(menu: params[:session][:menu]) unless params[:session][:menu] ==""
   redirect_to  user_role_users_users_path
end

def user_permission_create
   # binding.pry
 @user = current_user
   
@menu =  Menu.find_by(id: params[:session][:menu_id]) 
 @menu.actions.create(action: params[:session][:action]) 
   
   redirect_to  user_role_users_users_path
end


def block
  # binding.pry
   
  @user = User.find_by(id: params[:id])
      if @user.status == false  
          @user.update(status:true)

          session[:user_id] = nil

      else
          @user.update(status:false)
      end
      redirect_to  users_users_users_path(current_user)
end


def user_destroy
    # binding.pry
  @user = User.find_by(id: params[:id])
  @user.destroy
 
  redirect_to users_users_users_path
  end

def content_destroy
@content = StaticContent.find_by(id: params[:id])
@content.destroy
redirect_to show_content_users_users_path
end

def permission_management
 @user = current_user
 @UserRoles = UserRole.all

end

def return_actions
          # binding.pry
        @menu = Menu.find(params[:code])
        @actions = @menu.actions.pluck(:action)
        render json: {fields: @actions}
    
    end


def save_permission
# binding.pry
# @role = UserRole.find_by(id:params[:permission][:role]).name
@roles = UserRole.find_by(id: params[:permission][:role])
a = Menu.find_by(id:params[:permission][:menus]).id
@action = @roles.permissions.create(menu_id:a,permission: params[:permission][:action])
 redirect_to permission_management_admins_admins_path 
end




def permission_destroy
  # binding.pry
@permission = Permission.find_by(id: params[:id])
@permission.destroy

redirect_to permission_management_admins_admins_path
end


def role_destroy
@role = UserRole.find_by(id: params[:id])
@role.destroy
redirect_to user_role_users_users_path
end

def menu_destroy
@menu = Menu.find_by(id: params[:id])
@menu.destroy
redirect_to user_role_users_users_path
end
def content_edit
  # binding.pry
 @user = current_user
 @content = StaticContent.find_by(id: params[:id]) 
end


def content_update
  # binding.pry
  @content = StaticContent.find_by(id: params[:id])
  @content.update(content_update_params)
redirect_to show_content_users_users_path
end
 def check_action
    # binding.pry
    a = UserRole.find_by(id:params[:roles]).permissions #Whatever your logic is to find duplicate emails
     b = a.pluck(:permission)
     c = b.include? params[:actions] 
    message = c ? "ERROR" : "SUCCESS"

    render json: {message: message}
  end


private

  def user_params
    params.require(:user).permit(:name , :email , :phone , :password , :password_confirmation,:avatar,:otp)
  end


def content_params
    params.require(:session).permit(:title,:latest_content,:start_date,:end_date)
  end


def content_update_params
    params.require(:content).permit(:title,:latest_content,:start_date,:end_date)
  end

 def user_params
    params.require(:user).permit(:name , :email , :phone , :password , :password_confirmation,:avatar,:user_role_id , :remote_ip,:user_agent)
  end

def require_login 
   unless logged_in?
      flash[:notice] = "You must be logged in to access this section"
      redirect_to new_users_session_path
    end
  end


def status_check
   if current_user.status == true
    flash[:notice] = "You are blocked by admin"
    redirect_to new_users_session_path
end
end

def set_current_ip
  # binding.pry
  a = User.find_by(id: current_user.id)
  a.update(remote_ip: request.ip)
   a.update(user_agent: request.env['HTTP_USER_AGENT'])
end
def content_update_params
   params.require(:content).permit(:title,:latest_content,:start_date,:end_date)
 end


end

	
 

 
  
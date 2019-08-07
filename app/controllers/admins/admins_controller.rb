class Admins::AdminsController < Admins::BaseAdminController

 before_action :require_login_a, except: [:new , :create , :otp ,:otp_admin ,:return_actions,:check_action,:check_menus_action]
 

 
def new
   redirect_to admins_admin_path(current_user_a) if logged_in_a?  
  end

def create_user

  @user=User.new
	 @admin = current_user_a

end

def create_users
  # binding.pry
@user = User.new(user_params)
     if @user.save
      
     redirect_to  users_admins_admins_path
    else

      redirect_to create_user_admins_admins_path
      
    end 
end
 
def users
  if logged_in_a? 
  @admin = current_user_a
  @users = User.all.order("created_at desc").paginate(:page => params[:page], :per_page => 5)

else
redirect_to new_admins_session_path
end
end



def dashboard
	 @admin = current_user_a
end

def static_content
	 @admin = current_user_a
end

def content_create
	 @admin = current_user_a 
	 @content = StaticContent.create(content_params)
	 redirect_to show_content_admins_admins_path
end

def user_view
   @admin = current_user_a
 
  @user = User.find_by(id: params[:id])

end

def show_content

 @admin = current_user_a
@contents = StaticContent.order("created_at desc").paginate(:page => params[:page], :per_page => 5)


end


def user_role_update
# binding.pry
 @admin = current_user_a
unless params[:session][:user_role_id] == ""
@user = User.find_by(id: params[:id])
  @user.update!(user_role_id: params[:session][:user_role_id])
  redirect_to users_admins_admins_path(current_user_a)
end
end


def user_role
 @admin = current_user_a

end

def user_role_create
  # binding.pry
 @admin = current_user_a

  @role = UserRole.create(name: params[:session][:name]) unless params[:session][:name]==""
  @menu = Menu.create(menu: params[:session][:menu]) unless params[:session][:menu] ==""
   redirect_to  user_role_admins_admins_path
end

def user_permission_create
   # binding.pry
 @admin = current_user_a
   
@menu =  Menu.find_by(id: params[:session][:menu_id]) 
 @menu.actions.create(action: params[:session][:action]) 
   
   redirect_to  user_role_admins_admins_path
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
      redirect_to  users_admins_admins_path(current_user_a)
end


def user_destroy
    binding.pry
  @user = User.find_by(id: params[:id])
  @user.destroy
 
  redirect_to users_admins_admins_path
  end

def content_destroy
@content = StaticContent.find_by(id: params[:id])
@content.destroy
redirect_to show_content_admins_admins_path
end

def permission_management
 
 @admin = current_user_a
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
@roles = UserRole.find_by(id: params[:roles])
 @action = @roles.permissions.create(menu_id:params[:menus],permission: params[:actions]) 


 redirect_to permission_management_admins_admins_path
end




def permission_destroy
  # binding.pry
@permission = Permission.find_by(id: params[:id])
@permission&.destroy

redirect_to permission_management_admins_admins_path
end

def role_destroy
@role = UserRole.find_by(id: params[:id])
@role.destroy
redirect_to user_role_admins_admins_path
end

# def menu_destroy
# @menu = Menu.find_by(id: params[:id])
# @menu.destroy
# redirect_to user_role_admins_admins_path
# end

def content_edit
 @admin = current_user_a
 @content = StaticContent.find_by(id: params[:id]) 
end


def content_update
  # binding.pry
  @content = StaticContent.find_by(id: params[:id])
  @content.update(content_update_params)
redirect_to show_content_admins_admins_path
end


  def check_action

    # binding.pry
    role = UserRole.find_by(id:params[:roles]).permissions #Whatever your logic is to find duplicate emails
      permission = role.pluck(:permission,:menu_id)
      @menu = Menu.find_by(id:params[:menus]) 
     c = permission.include? [params[:actions] ,params[:menus]]

    message = c ? "ERROR" : "SUCCESS"
    if message == "ERROR"

    render json: {message: message}
else
  # binding.pry
  @roles = UserRole.find_by(id: params[:roles])
 @action = @roles.permissions.create(menu_id:params[:menus],permission: params[:actions])
      flash.now[:notice] = "Please Refresh the page"

 redirect_to permission_management_admins_admins_path
  # save_permission(id:@menu.id)
end

  end

# def check_menus_action
#   # binding.pry
#   a = Menu.find_by(id: params[:menus]).actions
#   @value = Menu.find_by(id: params[:menus]).menu

#   b = a.pluck(:action)
#   c = b.include? params[:actions]
#     message = c ? "ERROR" : "SUCCESS"
#     render json: {message: message, value: @value , action:params[:actions]}

# end



private
def content_params
    params.require(:session).permit(:title,:latest_content,:start_date,:end_date)
  end


def content_update_params
    params.require(:content).permit(:title,:latest_content,:start_date,:end_date)
  end


 def user_params
    params.require(:user).permit(:name , :email , :phone , :password , :password_confirmation,:avatar,:user_role_id)
  end

def permission_params
    params.require(:permission).permit(:action , :menus , :role ,:user_role_id, :menu_id)
  end

   

def require_login_a
  # binding.pry
    unless logged_in_a?
      flash[:notice] = "You must be logged in to access this section"
      redirect_to new_admins_session_path 
    end
  end
end
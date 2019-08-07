class Api::V1::AdminsController < ApplicationController

#   before_action :require_login_a, except: [:new , :create , :otp ,:otp_admin ,:dashboard]
 

 
# def new
  
#   end

# def create_user
#    # binding.pry
# @user=User.new
#    @admin = current_user_a

# end

def create_users
  binding.pry
@user = User.new(user_params)
     if @user.save
      render json: {
            responseCode: 201,
            responseMessage: "user created successfully."
             } 
      
    else
      
      render json: {
            responseCode: 422,
            responseMessage: "not created"
             }
    end
end
 
# def show
#   if logged_in_a? 
#   @admin = current_user_a
#   @users = User.order("created_at desc").paginate(:page => params[:page], :per_page => 5)

# else
# redirect_to new_admins_session_path
# end
# end



# def dashboard
#    @admin = current_user_a
# end

# def static_content
#    @admin = current_user_a
# end

# def content_create
#    @admin = current_user_a
#    @content = StaticContent.create(content_params)
#    redirect_to show_content_admins_admins_path
# end

# def user_view
#   @user = User.find_by(id: params[:id])

# end

# def show_content

#  @admin = current_user_a
# @contents = StaticContent.order("created_at desc").paginate(:page => params[:page], :per_page => 5)


# end


# def user_role_update
# # binding.pry
#  @admin = current_user_a

# @user = User.find_by(id: params[:id])
#   @user.update(user_role_id: params[:session][:user_role_id])
#   redirect_to admins_admin_path(current_user_a)
# end


# def user_role
#  @admin = current_user_a

# end

# def user_role_create
#   # binding.pry
#  @admin = current_user_a

#   @role = UserRole.create(name: params[:session][:name]) 
   
#    redirect_to  user_role_admins_admins_path
# end

# def user_permission_create
#   # binding.pry
#  @admin = current_user_a
#    @permission = UserRole.find_by(id: params[:session][:user_role_id])

#  @permission.permissions.create(permission: params[:session][:permission]) 
   
#    redirect_to  user_role_admins_admins_path
# end


# def block
#   # binding.pry
   
#   @user = User.find_by(id: params[:id])
#       if @user.status == false  
#           @user.update(status:true)

#           session[:user_id] = nil

#       else
#           @user.update(status:false)
#       end
#       redirect_to  admins_admin_path(current_user_a)
# end


# def user_destroy
#     # binding.pry
#   @user = User.find_by(id: params[:id])
#   @user.destroy
 
#   redirect_to admins_admins_path
#   end

# def content_destroy
# @content = StaticContent.find_by(id: params[:id])
# @content.destroy
# redirect_to show_content_admins_admins_path
# end



# private
# def content_params
#     params.require(:session).permit(:title,:latest_content,:start_date,:end_date)
#   end



 def user_params
  binding.pry
    params.require(:user).permit(:name , :email , :phone , :password , :password_confirmation,:avatar)
  end
# def require_login_a
#   # binding.pry
#     unless logged_in_a?
#       flash[:notice] = "You must be logged in to access this section"
#       redirect_to new_admins_session_path 
#     end
#   end





end


module AdminsHelper

def log_in_a(admin)
    session[:admin_id] = @admin.id
  end


  def current_user_a
    # binding.pry
    if session[:admin_id]
      @current_user_a ||= Admin.find_by(id: session[:admin_id])
    end
  end


  def logged_in_a?
    # binding.pry
    !current_user_a.nil?
  end

   def log_out_a
    # binding.pry
    session.delete(:admin_id )
    @current_user_a = nil
  end
  def role
    @role = UserRole.all
  end
  
end
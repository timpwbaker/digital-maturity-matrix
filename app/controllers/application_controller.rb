class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception



  private

  def is_admin
    if !user_signed_in?
    	authenticate_user!
    elsif !current_user.admin?
      respond_to do |format|
        format.html { redirect_to root_path, notice: 'You do not have access to this area'  }
        #Or do something else here
      end
    end
  end

end

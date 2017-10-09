class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def is_admin
    if !user_signed_in?
      authenticate_user!
    elsif !current_user.admin?
      respond_to do |format|
        format.html do
          redirect_to root_path,
                      notice: 'You do not have access to this area'
        end
      end
    end
  end
end

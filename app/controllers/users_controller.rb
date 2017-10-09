class UsersController < ApplicationController
  before_action :is_admin
  before_action :is_admin, only: [:index]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    unless @user == current_user || current_user.admin?
      redirect_to root_path, alert: 'Access denied.'
    end
  end
end

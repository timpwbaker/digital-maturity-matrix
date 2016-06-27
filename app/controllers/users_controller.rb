class UsersController < ApplicationController
  before_action :is_admin
  before_action :is_admin, only: [:index]


  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    unless @user == current_user || current_user.admin?
      redirect_to :back, :alert => "Access denied."
    end
  end

private

    # Never trust parameters from the scary internet, only allow the white list through.
    def submission_params
      params.permit(:paid)
    end

end
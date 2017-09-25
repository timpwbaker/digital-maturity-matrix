class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, only: [:new, :create, :update]

  def create
    super
    if resource.persisted?
      current_user.send_welcome_email
    end
  end

  def edit
    super
  end

  def update
    super
  end
end

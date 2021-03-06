class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, only: [:new, :create, :update]

  def new
    super
  end

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
  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(
      :account_update,
      keys: [
        :name,
        :organisation,
        :organisation_turnover,
        :organisation_size,
        :digital_size, :opt_in
      ]
    )
    devise_parameter_sanitizer.permit(
      :sign_up,
      keys: [
        :name,
        :organisation,
        :organisation_turnover,
        :organisation_size,
        :digital_size,
        :opt_in
      ]
    )
  end
end

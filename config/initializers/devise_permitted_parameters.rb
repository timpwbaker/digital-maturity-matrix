module DevisePermittedParameters
  extend ActiveSupport::Concern

  included do
    before_action :configure_permitted_parameters
  end

  protected

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

DeviseController.send :include, DevisePermittedParameters

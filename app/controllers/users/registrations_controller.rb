class Users::RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters, only: [:new, :create, :update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    super
    if resource.persisted?
      Pony.mail(
        to: current_user.email,
        from: 'digital@breastcancercare.org.uk',
        subject: 'Welcome to the Third Sector Digital Maturity Matrix',
        html_body: '<h2>Hello ' + current_user.name + '</h2>
        <p>Thank you for signing up to create a Third Sector Digital Maturity Matrix.
        <p>Visit the site to create your Maturity Matrix
        <a href="http://digitalmaturity.co.uk/">http://digitalmaturity.co.uk/</a>.
        <p>If you have any issues, contact
        <a href="mailto:digital@breastcancercare.org.uk">digital@breastcancercare.org.uk</a>
        and we’ll get back to you as soon as we can.<p>All the best.<p>Breast Cancer Care Digital Team'
      )
    end
  end

  # GET /resource/edit
  def edit
    super
  end

  def update
    super
  end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(
      :account_update,
      keys: [
        :name,
        :organisation,
        :organisation_turnover,
        :organisation_size,
        :digital_size,
        :opt_in
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
  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end

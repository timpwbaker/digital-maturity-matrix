class ApiKeysController < ApplicationController
  def create
    current_user.update_attribute(:api_key, SecureRandom.hex)

    redirect_to user_api_key_path(current_user)
  end

  def show
    render locals: {user: current_user}
  end
end

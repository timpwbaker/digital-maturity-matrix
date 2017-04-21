class ApiKeysController < ApplicationController

  def create
    current_user.api_key = SecureRandom.hex
    current_user.save

    redirect_to user_api_key_path(current_user)
  end

  def show
    render locals: {user: current_user}
  end
end

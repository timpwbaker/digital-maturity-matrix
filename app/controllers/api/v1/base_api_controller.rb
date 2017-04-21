module Api
  module V1
    class BaseApiController < ApplicationController
      before_filter :authenticate_user_from_key!
      skip_before_filter :verify_authenticity_token

      private

      def authenticate_user_from_key!
        if !params[:api_key]
          render nothing: true, status: :unauthorized
        else
          User.find_each do |user|
            if Devise.secure_compare(user.api_key, params[:api_key])
              @user = user
            end
          end
        end
      end
    end
  end
end

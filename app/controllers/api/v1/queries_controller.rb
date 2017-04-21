module Api
  module V1
    class QueriesController < BaseApiController
      def create
        render json: Submission.where(user_id: @user.id).first
      end
    end
  end
end

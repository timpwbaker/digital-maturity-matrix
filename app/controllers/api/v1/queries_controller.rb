module Api
  module V1
    class QueriesController < BaseApiController
      def create
        if submissions.count > 9
          render locals: {submissions: submissions}
        else
          render json: {'response' => 'Sorry, there is not enough data'}
        end
      end

      private

      def submissions
        users = find_users(query_params)
        find_submissions(users)
      end

      def query_params
        params.require(:query).permit(
          :organisation_turnover,
          :organisation_size,
          :digital_size
        ).reject{|_, v| v.blank?}
      end

      def find_users(query_params)
        User.where(query_params)
      end

      def find_submissions(users)
        Submission.where(user_id: users.map(&:id))
      end
    end
  end
end

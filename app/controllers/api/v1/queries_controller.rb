module Api
  module V1
    class QueriesController < BaseApiController
      def create
        users = find_users
        submissions = find_submissions(users)
        json = create_json(submissions)
        if submissions.count < 10
          render json: { errors: 'Sorry, there isn\'t enough data' }
        else
          render json: json
        end
      end

      private

      def find_users
        users =  User.all
        if params[:organisation_turnover]
          users = users.where(organisaion_turnover: params[:organisaion_turnover])
        end
        if params[:organisation_size]
          users = users.where(organisation_size: params[:organisation_size])
        end
        if params[:digital_size]
          users = users.where(digital_size: params[:digital_size])
        end
        users
      end

      def find_submissions(users)
        user_ids = users.map(&:id)
        Array(Submission.where(user_id: user_ids))
      end

      def create_json(submissions)
        if submissions.count > 0
          current_averages = {}
          target_averages = {}
          Matrix.digital_maturity_areas.each do |area|
            total_current = submissions.inject(0) { |total, submission| total = total + submission.top_line_current_hash[area].to_i }
            average_current = total_current/submissions.count
            current_averages[area] = average_current
            total_targets = submissions.inject(0) { |total, submission| total = total + submission.top_line_target_hash[area].to_i }
            average_target = total_targets/submissions.count
            target_averages[area] = average_target
          end
          {"Average current maturity": current_averages, "Average target maturity": target_averages}.to_json
        end
      end
    end
  end
end

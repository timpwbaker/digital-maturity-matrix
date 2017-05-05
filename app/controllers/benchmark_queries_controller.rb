class BenchmarkQueriesController < ApplicationController

  def create
    if submissions.count > 9
      render locals: {submissions: submissions, query_params: query_params}
    else
      flash[:alert] = "Sorry there's not enough data, try widening your search"
      redirect_to new_benchmark_query_path(query_params)
    end
  end

  private

  def query_params_string
    query_params.eval
  end

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

class SubmissionsCsvsController < ApplicationController
  before_action :is_admin

  def create
    send_data Submission.to_csv(submissions), filename: "submissions-#{Date.today}.csv"
  end

  private

  def matrix
    Matrix.find(params[:matrix_id])
  end

  def submissions
    matrix.submissions
  end
end

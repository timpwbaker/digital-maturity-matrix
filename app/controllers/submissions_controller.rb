# This controller acts on submissions, which belong to matrices and users.
class SubmissionsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :new, :edit, :index]
  before_action :require_submission_permission, only: [:show, :update]
  before_action :is_admin, only: [:index]
  before_action :is_only_submission, only: :new

  def index
    render locals: { matrix: matrix, submissions: matrix.submissions }
  end

  def show
    render locals: {
      matrix: matrix,
      submission: submission,
      answers: submission.answers_ordered_by_question_area,
      targets: submission.targets_ordered_by_question_area,
    }
  end

  def new
    render locals: {
      matrix: matrix,
      submission: submission,
    }
  end

  def edit
    render locals: {
      matrix: matrix,
      submission: submission,
      start_area: area
    }
  end

  def create
    new_submission = Submission.new(submission_params)
    if new_submission.save
      redirect_to matrix_submission_path(matrix, new_submission),
        notice: "Your digital maturity matrix has been saved"
    else
      format.html { render :new }
    end
  end

  def update
      if submission.update(submission_params)
        submission.update_attribute(:s3_url, nil)
        redirect_to matrix_submission_path(matrix, submission),
          notice: 'Submission was successfully updated.'
      else
        render :edit
      end
  end

  def destroy
    submission.destroy
    redirect_to matrix_submissions_url,
      notice: 'Submission was successfully destroyed.'
  end

  private

  def matrix
    Matrix.find(params[:matrix_id])
  end

  def submission
    Submission.find_by_id(params[:id]) || Submission.new
  end

  def area
    if params.key?(:area)
      params[:area].delete(' ').delete('&')
    else
      'Technology'
    end
  end

  def is_only_submission
    if Submission.where(matrix: matrix, user: current_user).any?
      redirect_to(
          edit_matrix_submission_path(matrix,
                                      Submission.where(matrix: matrix).find_by_user_id(current_user.id)),
          notice: 'You can only have one matrix per account.'
      )
    end
  end

  def submission_params
    params.require(:submission).permit(
        :matrix_id,
        :user_id,
        :name,
        :s3_url,
        answers: Hash[Matrix.digital_maturity_areas.map{ |area| [area,  matrix.questions.where("area = ?", area).map{|question| question.id.to_s }]}],
        targets: Hash[Matrix.digital_maturity_areas.map{ |area| [area,  matrix.questions.where("area = ?", area).map{|question| question.id.to_s }]}],
    )
  end

  def require_submission_permission
    if user_signed_in?
      if !current_user.admin? && current_user != Submission.find(params[:id]).user
        redirect_to root_path,
          notice: 'This doesn\'t appear to be your matrix.
                        If it is try signing in to a different account'
      end
    else
      authenticate_user!
    end
  end
end

class SubmissionsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :new, :edit, :index]
  before_action :require_submission_permission, only: [:show, :update]
  before_action :is_admin, only: [:index]
  before_action :is_only_submission, only: :new

  def index
    render locals: { matrix: matrix, submissions: matrix.submissions }
  end

  def show
    render locals: { submission: submission }
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
      PdfBuilderWorker.perform_async(new_submission.id)
      redirect_to matrix_submission_path(matrix, new_submission),
        notice: "Your digital maturity matrix has been saved"
    else
      render :new, { matrix: matrix, submission: new_submission }
    end
  end

  def update
      if submission.update(submission_params)
        submission.update(s3_url: nil)
        PdfBuilderWorker.perform_async(submission.id)
        redirect_to matrix_submission_path(matrix, submission),
          notice: 'Submission was successfully updated.'
      else
        render :edit, locals: { matrix: matrix, submission: submission }
      end
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
    if current_user.submission
      redirect_to edit_matrix_submission_path(matrix, current_user.submission),
        notice: 'You can only have one matrix per account.'
    end
  end

  def submission_params
    params.require(:submission).permit(
        :matrix_id,
        :user_id,
        :name,
        :s3_url,
        answers_json: permitted_answers_targets_hash,
        targets_json: permitted_answers_targets_hash,
    )
  end

  def permitted_answers_targets_hash
    Hash[Matrix.digital_maturity_areas.map{ |area| 
      [area,  matrix.questions.where("area = ?", area).map{|question| 
        question.id.to_s }]
    }]
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

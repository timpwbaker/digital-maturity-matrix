# This controller acts on answers, which belong to questions and submissions.
class AnswersController < ApplicationController
  before_action :set_answer, only: [:show, :edit, :update, :destroy]

  # GET /answers
  # GET /answers.json
  def index
    @matrix = Matrix.find(params[:matrix_id])
    @submission = Submission.find(params[:submission_id])
    @answers = Answer.all
  end

  # GET /answers/1
  # GET /answers/1.json
  def show
  end

  # GET /answers/new
  def new
    @matrix = Matrix.find(params[:matrix_id])
    @submission = Submission.find(params[:submission_id])
    @questions = @matrix.questions
    @answer = Answer.new
  end

  # GET /answers/1/edit
  def edit
    @matrix = Matrix.find(params[:matrix_id])
    @submission = Submission.find(params[:submission_id])
  end

  # POST /answers
  # POST /answers.json
  def create
    @answer = Answer.new(answer_params)
    respond_to do |format|
      if @answer.save
        format.html do
          redirect_to @answer, notice: 'Answer was successfully created.'
        end
        format.json do
          render :show, status: :created, location: @answer
        end
      else
        format.html { render :new }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /answers/1
  # PATCH/PUT /answers/1.json
  def update
    @matrix = Matrix.find(params[:matrix_id])
    @submission = Submission.find(params[:submission_id])
    respond_to do |format|
      if @answer.update(answer_params)
        format.html do
          redirect_to matrix_submission_answer_path(@matrix, @submission, @answer),
                      notice: 'Answer was successfully updated.'
        end
        format.json do
          render :show,
                 status: :ok,
                 location: matrix_submission_answer_path(@matrix, @submission, @answer)
        end
      else
        format.html do
          render :edit
        end
        format.json do
          render json: @answer.errors,
                 status: :unprocessable_entity
        end
      end
    end
  end

  # DELETE /answers/1
  # DELETE /answers/1.json
  def destroy
    @answer.destroy
    respond_to do |format|
      format.html do
        redirect_to answers_url,
                    notice: 'Answer was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_answer
    @answer = Answer.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def answer_params
    params.require(:answer).permit(
      :id,
      :question_answered,
      :choice,
      :question_id,
      :score
    )
  end
end

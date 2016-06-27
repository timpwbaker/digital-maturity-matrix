# This controller acts on questions, which belong to matrices, admin only!
class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  before_action :is_admin

  # GET /questions
  # GET /questions.json
  def index
    @matrix = Matrix.find(params[:matrix_id])
    @questions = @matrix.questions
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
    @matrix = Matrix.find(params[:matrix_id])
    @questions = @matrix.questions
  end

  # GET /questions/new
  def new
    @question = Question.new
    @matrix = Matrix.find(params[:matrix_id])
  end

  # GET /questions/1/edit
  def edit
    @matrix = Matrix.find(params[:matrix_id])
    @question = Question.find(params[:id])
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(question_params)
    @matrix_id = params[:matrix_id]
    respond_to do |format|
      if @question.save
        format.html do
          redirect_to matrix_questions_url,
                      notice: 'Question was successfully created.'
        end
        format.json do
          render :show,
                 status: :created,
                 location: @question
        end
      else
        format.html do
          render :new
        end
        format.json do
          render json: @question.errors,
                 status: :unprocessable_entity
        end
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    @matrix = Matrix.find(params[:matrix_id])
    @question = Question.find(params[:id])
    respond_to do |format|
      if @question.update(question_params)
        format.html do
          redirect_to matrix_questions_url,
                      notice: 'Question was successfully updated.'
        end
        format.json do
          render :show,
                 status: :ok,
                 location: @question
        end
      else
        format.html do
          render :edit
        end
        format.json do
          render json: @question.errors,
                 status: :unprocessable_entity
        end
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html do
        redirect_to matrix_questions_url,
                    notice: 'Question was successfully destroyed.'
      end
      format.json do
        head :no_content
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_question
    @question = Question.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def question_params
    params.require(:question).permit(:body, :area, :matrix_id)
  end
end

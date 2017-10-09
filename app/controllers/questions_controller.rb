# This controller acts on questions, which belong to matrices, admin only!
class QuestionsController < ApplicationController
  before_action :is_admin

  def new
    render locals: { matrix: matrix, question: Question.new }
  end

  def edit
    render locals: { matrix: matrix, question: question }
  end

  def create
    new_question = Question.new(question_params)
    if new_question.save
      redirect_to matrix_path(matrix),
                  notice: 'Question was successfully created.'
    else
      render :new, locals: { matrix: matrix, question: new_question }
    end
  end

  def update
    if question.update(question_params)
      redirect_to matrix_path(matrix),
                  notice: 'Question was successfully updated.'
    else
      render :edit, locals: { matrix: matrix, question: question }
    end
  end

  def destroy
    question.destroy
      redirect_to matrix_path(matrix),
                notice: 'Question was successfully destroyed.'
  end

  private

  def matrix
    Matrix.find(params[:matrix_id])
  end

  def question
    Question.find(params[:id])
  end

  def questions
    matrix.questions
  end

  def question_params
    params.require(:question).permit(:body, :area, :matrix_id)
  end
end

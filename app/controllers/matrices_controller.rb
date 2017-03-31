# This controller acts on matrices, admin only!
class MatricesController < ApplicationController
  before_action :is_admin

  def index
    render locals: { matrices: Matrix.all }
  end

  def show
    render locals: { matrix: matrix, questions: questions }
  end

  def edit
    render locals: { matrix: matrix }
  end

  def new
    render locals: { matrix: Matrix.new }
  end

  def create
    matrix = Matrix.new(matrix_params)
    if matrix.save
      redirect_to matrix_url(matrix),
                  notice: 'Matrix was successfully created.'
    else
      render :new
    end
  end

  def update
    if matrix.update(matrix_params)
      redirect_to matrix_url(matrix),
                  notice: 'Matrix was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    matrix.destroy
    redirect_to matrices_url,
                notice: 'Matrix was successfully destroyed.'
  end

  private

  def matrix
    Matrix.find(params[:id])
  end

  def questions
    matrix.questions.order('area')
  end

  def matrix_params
    params.require(:matrix).permit(:name)
  end
end

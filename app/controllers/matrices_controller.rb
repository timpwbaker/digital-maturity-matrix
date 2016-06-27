# This controller acts on matrices, admin only!
class MatricesController < ApplicationController
  before_action :set_matrix, only: [:show, :edit, :update, :destroy]
  before_action :is_admin

  # GET /matrices
  # GET /matrices.json
  def index
    @matrices = Matrix.all
  end

  # GET /matrices/1
  # GET /matrices/1.json
  def show
    @matrix = Matrix.find(params[:id])
    @questions = @matrix.questions.order('area')
  end

  # GET /matrices/new
  def new
    @matrix = Matrix.new
  end

  # GET /matrices/1/edit
  def edit
  end

  # POST /matrices
  # POST /matrices.json
  def create
    @matrix = Matrix.new(matrix_params)

    respond_to do |format|
      if @matrix.save
        format.html do
          redirect_to @matrix,
                      notice: 'Matrix was successfully created.'
        end
        format.json do
          render :show,
                 status: :created,
                 location: @matrix
        end
      else
        format.html do
          render :new
        end
        format.json do
          render json: @matrix.errors,
                 status: :unprocessable_entity
        end
      end
    end
  end

  # PATCH/PUT /matrices/1
  # PATCH/PUT /matrices/1.json
  def update
    respond_to do |format|
      if @matrix.update(matrix_params)
        format.html do
          redirect_to @matrix,
                      notice: 'Matrix was successfully updated.'
        end
        format.json do
          render :show,
                 status: :ok,
                 location: @matrix
        end
      else
        format.html do
          render :edit
        end
        format.json do
          render json: @matrix.errors,
                 status: :unprocessable_entity
        end
      end
    end
  end

  # DELETE /matrices/1
  # DELETE /matrices/1.json
  def destroy
    @matrix.destroy
    respond_to do |format|
      format.html do
        redirect_to matrices_url,
                    notice: 'Matrix was successfully destroyed.'
      end
      format.json do
        head :no_content
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_matrix
    @matrix = Matrix.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def matrix_params
    params.require(:matrix).permit(:name)
  end
end

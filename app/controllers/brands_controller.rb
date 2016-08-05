# Brands controller. This controller allows users to add brand colours
class BrandsController < ApplicationController
  before_action :set_brand, only: [:show, :edit, :update, :destroy]

  # GET /brands
  # GET /brands.json
  def index
    @brands = Brand.all
  end

  # GET /brands/1
  # GET /brands/1.json
  def show
  end

  # GET /brands/new
  def new
    if Brand.exists?(user_id: current_user.id)
      @brand = Brand.find_by user_id: current_user.id
      @submission = Submission.find_by user_id: current_user.id
      redirect_to(
        edit_brand_path(current_user.brand, submission_id: @submission.id),
        notice: 'You can only have one set of brand colors per account.
        Please create another account, alternatively you can edit your brand here.'
      )
    else
      @submission = Submission.find(params[:submission_id])
      @matrix = @submission.matrix
      @brand = Brand.new
    end
  end

  # GET /brands/1/edit
  def edit
    @brand = Brand.find(params[:id])
    @submission = Submission.find(params[:submission_id])
    @matrix = @submission.matrix
  end

  # POST /brands
  # POST /brands.json
  def create
    @brand = Brand.new(brand_params)
    @submission = Submission.find(params[:brand][:submission_id])
    @matrix = Matrix.find(params[:brand][:matrix_id])
    respond_to do |format|
      if @brand.save
        format.html do
          redirect_to matrix_submission_path(@matrix, @submission),
                      notice: 'Brand was successfully created.'
        end
        format.json do
          render :show,
                 status: :created,
                 location: @brand
        end
      else
        format.html do
          render :new
        end
        format.json do
          render json: @brand.errors,
                 status: :unprocessable_entity
        end
      end
    end
  end

  # PATCH/PUT /brands/1
  # PATCH/PUT /brands/1.json
  def update
    @submission = Submission.find(params[:brand][:submission_id])
    @matrix = Matrix.find(params[:brand][:matrix_id])
    respond_to do |format|
      if @brand.update(brand_params)
        format.html do
          redirect_to matrix_submission_path(@matrix, @submission),
                      notice: 'Brand was successfully updated.'
        end
        format.json do
          render :show,
                 status: :ok,
                 location: @brand
        end
      else
        format.html do
          render :edit
        end
        format.json do
          render json: @brand.errors,
                 status: :unprocessable_entity
        end
      end
    end
  end

  # DELETE /brands/1
  # DELETE /brands/1.json
  def destroy
    @brand.destroy
    respond_to do |format|
      format.html do
        redirect_to brands_url,
                    notice: 'Brand was successfully destroyed.'
      end
      format.json do
        head :no_content
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_brand
    @brand = Brand.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def brand_params
    params.require(
      :brand
    )
          .permit(
            :user_id,
            :color_a,
            :color_b
          )
  end
end

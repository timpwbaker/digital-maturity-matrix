class BrandsController < ApplicationController
  before_action :no_existing_brand?, only: [:new]

  attr_reader :submission

  def new
    submission = Submission.find(params[:submission_id])
    render locals: { submission: submission,
                     matrix: submission.matrix,
                     brand: Brand.new }
  end

  def edit
    submission = Submission.find(params[:submission_id])
    render locals: { submission: submission,
                     matrix: submission.matrix,
                     brand: brand}
  end

  def create
    brand = Brand.new(brand_params)
    submission = Submission.find(params[:brand][:submission_id])
    if brand.save
      redirect_to matrix_submission_path(submission.matrix, submission),
        notice: 'Brand was successfully created.'
    else
      render :new
    end
  end

  def update
    submission = Submission.find(params[:brand][:submission_id])
    if brand.update(brand_params)
      redirect_to matrix_submission_path(submission.matrix, submission),
        notice: 'Brand was successfully updated.'
    else
      render :edit
    end
  end

  private

  def no_existing_brand?
    if current_user.brand
      redirect_to(
        edit_brand_path(current_user.brand, submission_id: submission.id),
        notice: 'You can only have one set of brand colors per account.'
      )
    end
  end

  def brand
    Brand.find(params[:id])
  end

  def brand_params
    params.require(:brand).permit(
      :user_id,
      :color_a,
      :color_b)
  end
end

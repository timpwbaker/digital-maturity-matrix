class SubmissionsController < ApplicationController
  before_action :set_submission, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:create, :new, :edit, :index]
  before_action :require_submission_permission, only: [:show, :update]

  # GET /submissions
  # GET /submissions.json
  def index
    @matrix = Matrix.find(params[:matrix_id])
    @submissions = Submission.all
  end

  # GET /submissions/1
  # GET /submissions/1.json
  def show
    get_submission_details
    get_topline_stats
    get_brand
    respond_to do |format|
      format.html
      format.pdf do
        render  javascript_delay: 2000,
                pdf:       'submission',
                layout:    'pdf', 
                template:  'submissions/showpdf.html.haml',
                show_as_html: params.key?('debug')

      end
    end            
  end


  def emailpdf
    get_submission_details
    get_topline_stats
    get_brand
    render  javascript_delay: 2000,
            pdf:       'submission',
            layout:    'pdf', 
            template:  'submissions/showpdf.html.haml',
            show_as_html: params.key?('debug'),
            save_to_file: Rails.root.join('pdf', "submission#{@user.id}.pdf"),
            save_only: true
    SendpdfJob.delay.perform_later(@user.name, @user.id, @user.email, @matrix.id, @submission.id)
    redirect_to matrix_submission_path(@matrix,@submission), notice: "We have emailed you your PDF"
  end

  # GET /submissions/new
  def new
    @user = current_user
    @matrix = Matrix.find(params[:matrix_id])
    if Submission.exists?(:user_id => current_user.id)
      @submission = Submission.find_by user_id: current_user.id
      redirect_to edit_matrix_submission_path(@matrix,@submission), notice: "You can only have one matrix per account. Please create another account, alternatively you can edit your existing matrix"
    else
      @submission = Submission.new
    end
    @questions = @matrix.questions.order("questions.area")
    @answer = Answer.new
    @target = Target.new
  end

  # GET /submissions/1/edit
  def edit
    get_submission_details
    if (params.has_key?(:area))
      @area = (params[:area])
    else
      @area = "Technology"
    end
  end

  def create
    @submission = Submission.new(submission_params)
    @matrix = Matrix.find(params[:matrix_id])
    @user_id = current_user
    respond_to do |format|
      if @submission.save
        format.html { redirect_to matrix_submission_path(@matrix,@submission), notice: @notice1 }
        format.json { render :show, status: :created, location: @submission }
        format.pdf do
          render pdf: "submission"   # Excluding ".pdf" extension.
        end
      else
        format.html { render :new }
        format.json { render json: @submission.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /submissions/1
  # PATCH/PUT /submissions/1.json
  def update
    @matrix = Matrix.find(params[:matrix_id])
    @user_id = current_user
    respond_to do |format|
      if @submission.update(submission_params)
        format.html { redirect_to matrix_submission_path(@matrix,@submission), notice: 'Submission was successfully updated.' }
        format.json { render :show, status: :ok, location: @submission }
        format.pdf do
          render pdf: "submission"   # Excluding ".pdf" extension.
        end
      else
        format.html { render :edit }
        format.json { render json: @submission.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /submissions/1
  # DELETE /submissions/1.json
  def destroy
    @submission.destroy
    respond_to do |format|
      format.html { redirect_to matrix_submissions_url, notice: 'Submission was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private
    def get_brand
      if !Brand.exists?(user_id: @user.id)
        @brand_1 = "rgba(0,255,0,1)"
        @brand_2 = "rgba(255,0,0,1)"
      else
        @brand_1 = @user.brand.color_a
        @brand_2 = @user.brand.color_b
      end
    end

    def get_submission_details
      @matrix = Matrix.find(params[:matrix_id])
      @submission = Submission.find(params[:id])
      @user = @submission.user
      @questions = @matrix.questions
      @answers = @submission.answers.joins(:question).order("questions.area").order("questions.id")
      @targets = @submission.targets.joins(:question).order("questions.area").order("questions.id")
    end

    def get_topline_stats
      @current = (@answers.sum("score")/Matrix.digital_maturity_areas.count).round(0)
      @target = (@targets.sum("score")/Matrix.digital_maturity_areas.count).round(0)
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_submission
      @submission = Submission.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def submission_params
      params.require(:submission).permit(:matrix_id, :user_id, :name, :answers_attributes => [:id, :question_answered, :choice, :question_id, :score], :targets_attributes => [:id, :question_answered, :choice, :question_id, :score])
    end

    def require_submission_permission
      if user_signed_in?
        if !current_user.admin? && current_user != Submission.find(params[:id]).user
          respond_to do |format|
            format.html { redirect_to root_path, notice: 'This doesn\'t appear to be your matrix. If it is try signing in to a different account'  }
            #Or do something else here
          end
        end
      else
        authenticate_user!
      end
    end
end

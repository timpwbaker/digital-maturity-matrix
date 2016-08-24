# This controller acts on submissions, which belong to matrices and users.
class SubmissionsController < ApplicationController
  before_action :set_submission, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:create, :new, :edit, :index]
  before_action :require_submission_permission, only: [:show, :update]

  # GET /submissions
  # GET /submissions.json
  def index
    @matrix = Matrix.find(params[:matrix_id])
    @submissions = Submission.all
    respond_to do |format|
      format.html
      format.csv { send_data Submission.to_csv(@submissions), filename: "submissions-#{Date.today}.csv" }
    end
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
        if !@submission.s3_url
          create_and_save_pdf
          @submission.save
        end
        redirect_to @submission.s3_url
      end
    end
  end

  def emailpdf
    get_submission_details
    get_topline_stats
    get_brand
    if !@submission.s3_url
      create_and_save_pdf
      @submission.save
    end
    send_email_pdf(@user.id, @user.name, @user.email, @submission.s3_url)
    redirect_to(
      matrix_submission_path(@matrix, @submission),
      notice: 'We have emailed you your PDF'
    )
  end

  def emailpdf_api
    get_submission_details
    get_topline_stats
    get_brand
    makepost(@user.name, @user.email, @submission.s3_url)
    redirect_to matrix_submission_path(@matrix,@submission), notice: "We have emailed you your PDF"
  end


  # GET /submissions/new
  def new
    @user = current_user
    @matrix = Matrix.find(params[:matrix_id])
    @questions = @matrix.questions.order('questions.area')
    @answer = Answer.new
    @target = Target.new
    if Submission.exists?(user_id: current_user.id)
      @submission = Submission.find_by user_id: current_user.id
      redirect_to(
        edit_matrix_submission_path(@matrix, @submission),
        notice: 'You can only have one matrix per account.
        Please create another account, alternatively you can edit your existing matrix'
      )
    else
      @submission = Submission.new
    end
  end

  # GET /submissions/1/edit
  def edit
    get_submission_details
    @area = if params.key?(:area)
              params[:area]
            else
              'Technology'
            end
  end

  def create
    @submission = Submission.new(submission_params)
    @matrix = Matrix.find(params[:matrix_id])
    @user_id = current_user
    respond_to do |format|
      if @submission.save
        format.html do
          redirect_to matrix_submission_path(@matrix, @submission),
                      notice: @notice1
        end
        format.json do
          render :show,
                 status: :created,
                 location: @submission
        end
        format.pdf do
          render pdf: 'submission'
        end
      else
        format.html { render :new }
        format.json do
          render json: @submission.errors,
                 status: :unprocessable_entity
        end
      end
    end
  end

  # PATCH/PUT /submissions/1
  # PATCH/PUT /submissions/1.json
  def update
    @matrix = Matrix.find(params[:matrix_id])
    @user_id = current_user
    create_and_save_pdf
    respond_to do |format|
      if @submission.update(submission_params)
        format.html do
          redirect_to matrix_submission_path(@matrix, @submission),
                      notice: 'Submission was successfully updated.'
        end
        format.json do
          render :show,
                 status: :ok,
                 location: @submission
        end
        format.pdf do
          render pdf: 'submission'
        end
      else
        format.html { render :edit }
        format.json do
          render json: @submission.errors,
                 status: :unprocessable_entity
        end
      end
    end
  end

  # DELETE /submissions/1
  # DELETE /submissions/1.json
  def destroy
    @submission.destroy
    respond_to do |format|
      format.html do
        redirect_to matrix_submissions_url,
                    notice: 'Submission was successfully destroyed.'
      end
      format.json do
        head :no_content
      end
    end
  end

  public

  def create_and_save_pdf
    get_submission_details
    get_topline_stats
    get_brand
    rand = SecureRandom.hex
    render  javascript_delay: 2000,
            pdf:       'submission',
            layout:    'pdf', 
            template:  'submissions/showpdf.html.haml',
            show_as_html: params.key?('debug'),
            save_to_file: Rails.root.join('pdf', "submission#{rand}.pdf"),
            save_only: true
    @submission.s3_url = to_s3_return_url(rand)
  end


  def get_brand
    if !Brand.exists?(user_id: @user.id)
      @brand_1 = 'rgba(0,255,0,1)'
      @brand_2 = 'rgba(255,0,0,1)'
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
    @answers = @submission.answers.joins(:question).order('questions.area').order('questions.id')
    @targets = @submission.targets.joins(:question).order('questions.area').order('questions.id')
  end

  def get_topline_stats
    @current = (@answers.sum('score') / Matrix.digital_maturity_areas.count).round(0)
    @target = (@targets.sum('score') / Matrix.digital_maturity_areas.count).round(0)
  end

  def send_email_pdf(userid, username, useremail, fileurl)
    require 'open-uri'
    @file = open(fileurl).read
    Pony.mail(
      to: useremail,
      from: 'digital@breastcancercare.org.uk',
      subject: 'Here’s your Third Sector Digital Maturity Matrix',
      html_body: '<h2>Hello ' + username + '.</h2>
        <p> Your Maturity Matrix is attached. We hope you find this useful.
        <p> We’d love to know what you think, so please email
        <a href="mailto:digital@breastcancercare.org.uk">digital@breastcancercare.org.uk</a>
        with any feedback or questions.
        <p >All the best
        <p> Breast Cancer Care Digital Team',
      attachments: {
        'matrix.pdf' => @file
      }
    )
  end

  def makepost(user_name, user_email, file_url)
    require "uri"
    require "net/http"

    uri = URI.parse("#{ENV['EMAIL_API_HOSTNAME']}api/v1/emails/post")

    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri.request_uri)
    request.set_form_data({
      'user_name' => user_name,
      'user_email' => user_email,
      'file_url' => file_url
    })
    response = http.request(request)

  end

  def to_s3_return_url(rand)
    s3 = Aws::S3::Resource.new(
      credentials: Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY']),
      region: ENV['AWS_REGION']
    )
     
    obj = s3.bucket(ENV['AWS_BUCKET']).object("submission#{rand}.pdf")
    obj.upload_file(Rails.root.join('pdf', "submission#{rand}.pdf"), acl:'public-read')
    puts obj.public_url
    return obj.public_url
  end
  
  private

  # Use callbacks to share common setup or constraints between actions.
  def set_submission
    @submission = Submission.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def submission_params
    params.require(:submission).permit(
      :matrix_id,
      :user_id,
      :name,
      :s3_url,
      answers_attributes: [
        :id,
        :question_answered,
        :choice,
        :question_id,
        :score
      ],
      targets_attributes: [
        :id,
        :question_answered,
        :choice,
        :question_id,
        :score
      ]
    )
  end

  def require_submission_permission
    if user_signed_in?
      if !current_user.admin? && current_user != Submission.find(params[:id]).user
        respond_to do |format|
          format.html do
            redirect_to root_path,
                        notice: 'This doesn\'t appear to be your matrix.
                        If it is try signing in to a different account'
          end
        end
      end
    else
      authenticate_user!
    end
  end
end

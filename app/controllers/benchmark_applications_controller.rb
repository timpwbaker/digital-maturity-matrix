class BenchmarkApplicationsController < ApplicationController
  before_action :set_benchmark_application, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :is_admin

  # GET /benchmark_applications
  # GET /benchmark_applications.json
  def index
    @benchmark_applications = BenchmarkApplication.all
  end

  # GET /benchmark_applications/1
  # GET /benchmark_applications/1.json
  def show
    @benchmark_application = BenchmarkApplication.find(params[:id])
    @user = BenchmarkApplication.find(params[:user_id])
  end

  # GET /benchmark_applications/new
  def new
    @user = current_user
    #if (params.has_key?(:donate))
    #  @form = "donateform"
    #else
      @form = "form"
    #end
    if BenchmarkApplication.exists?(:user_id => current_user.id)
      @benchmark_application =  BenchmarkApplication.find_by user_id: current_user.id
      redirect_to edit_user_benchmark_application_path(@user, @benchmark_application), notice: "You can only have one benchmark application per account. Please create another account, alternatively you can edit your existing benchmarking data here."
    else
      @benchmark_application = BenchmarkApplication.new
    end
    
  end

  # GET /benchmark_applications/1/edit
  def edit
    @user = current_user
  end

  # POST /benchmark_applications
  # POST /benchmark_applications.json
#  def create
 #   @benchmark_application = BenchmarkApplication.new(benchmark_application_params)
  #  respond_to do |format|
   #   if @benchmark_application.save
    #    format.html { redirect_to root_path, notice: 'Thanks for signing up to benchmarking.' }
     #   format.json { render :show, status: :created, location: @benchmark_application }
      #else
       # format.html { render :new }
       # format.json { render json: @benchmark_application.errors, status: :unprocessable_entity }
    #  end
  #  end
 # end

  def create
    @benchmark_application = BenchmarkApplication.new(benchmark_application_params)
    if params.has_key?(:stripeToken)
      current_user.paid = true
      current_user.card_token = params["stripeToken"]
      current_user.save
      @benchmark_application.card_token = params["stripeToken"]
      @benchmark_application.email = params["stripeEmail"]
      raise "Please, check errors" unless @benchmark_application.valid?
      @benchmark_application.process_payment
      @benchmark_application.save
      redirect_to root_path, notice: 'You have signed up to benchmarking'
    else
      respond_to do |format|
        if @benchmark_application.save
          format.html { redirect_to root_path, notice: 'Thanks for signing up to benchmarking.' }
          format.json { render :show, status: :created, location: @benchmark_application }
        else
          format.html { render :new }
          format.json { render json: @benchmark_application.errors, status: :unprocessable_entity }
        end
      end
    end
  end



  # PATCH/PUT /benchmark_applications/1
  # PATCH/PUT /benchmark_applications/1.json
  def update
    @user = current_user
    respond_to do |format|
      if @benchmark_application.update(benchmark_application_params)
        format.html { redirect_to root_path, notice: 'Benchmark data updated.' }
        format.json { render :show, status: :ok, location: @benchmark_application }
      else
        format.html { render :edit }
        format.json { render json: @benchmark_application.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /benchmark_applications/1
  # DELETE /benchmark_applications/1.json
  def destroy
    @benchmark_application.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'You have successfully left benchmarking.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_benchmark_application
      @benchmark_application = BenchmarkApplication.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def benchmark_application_params
      params.require(:benchmark_application).permit(:user_id, :organisation_turnover, :organisation_employees, :digital_employees, :organisation_name, :opt_in)
    end

    def stripe_params
      params.permit :stripeEmail, :stripeToken
    end
end

class CustomersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_customer, only: [:show, :edit, :update, :destroy]

  # GET /customers
  # GET /customers.json
  def index
    @customers = current_user.customers if current_user.customers!=nil
    @customers = [] if current_user.customers == nil
  end

  # GET /customers/1
  # GET /customers/1.json
  def show
  end

  # GET /customers/new
  def new
    @customer = Customer.new
  end

  # GET /customers/1/edit
  def edit
  end

  # POST /customers
  # POST /customers.json
  def create
    @customer = Customer.new(customer_params)
    @customer.user_id = current_user.id
    respond_to do |format|
      if @customer.save
        binding.pry
        @customer.update_attributes(otpsent: generate_otp({"mobile"=> @customer.mobile})) 
        @otpform = Otpform.new(mobile: @customer.mobile)
        format.html { redirect_to new_otpform_path(@otpform), notice: 'Please enter the otp sent to your mobile' }
        format.json { render :show, status: :created, location: @customer }
        binding.pry
      else
        format.html { render :new }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /customers/1
  # PATCH/PUT /customers/1.json
  def update
    respond_to do |format|
      if @customer.update(customer_params)
        format.html { redirect_to @customer, notice: 'Customer was successfully updated.' }
        format.json { render :show, status: :ok, location: @customer }
      else
        format.html { render :edit }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customers/1
  # DELETE /customers/1.json
  def destroy
    @customer.destroy
    respond_to do |format|
      format.html { redirect_to customers_url, notice: 'Customer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_params
      params.require(:customer).permit(:first_name, :last_name, :mobile, :otpsent, :otpreceived)
    end
    def generate_otp(hash)
      otp = Random.rand(594034..9304930943)
      p hash[:mobile]
      binding.pry
      response = HTTParty.get("https://smsapi.engineeringtgr.com/send/?Mobile=9972339927&Password=renault&Key=pmoha2ZgFoiDJqKMyjXEdT&Message=Hi%20bro&To=9448804242")
      p JSON.parse(response.body)
      return otp 
    end
end

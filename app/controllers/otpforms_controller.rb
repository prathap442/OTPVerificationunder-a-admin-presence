class OtpformsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_otpform, only: [:show, :edit, :destroy]

  # GET /otpforms
  # GET /otpforms.json
  def index
    @otpforms = current_user.otpforms
  end

  # GET /otpforms/1
  # GET /otpforms/1.json
  def show
    @otpform = Otpform.find(params[:id])
  end

  # GET /otpforms/new
  def new
    @otpform = Otpform.new
    
    @otpform.user_id = current_user.id
  end

  # GET /otpforms/1/edit
  def edit 
  end

  # POST /otpforms
  # POST /otpforms.json
  def create
    @otpform = Otpform.new(otpform_params)
    @otpform.user_id = current_user.id
    respond_to do |format|
      @customer = Customer.where(mobile: @otpform.mobile).first
      if(@otpform.otp_received==@customer.otpsent)
        @customer.update_attributes(verified: true)
        if ((@otpform.save) && (@customer.verified))
          format.html { redirect_to @otpform, notice: 'Otpform was successfully created' }
          format.json { render :show, status: :created, location: @otpform }
        else
          format.html { render :new }
          format.json { render json: @otpform.errors, status: :unprocessable_entity }
        end
      else
        @customer.update_attributes(verified: false)
        format.html { render :new,notice: "otp verification is been improper" }
        format.json { render json: @otpform.errors, status: :unprocessable_entity } 
      end  
    end
  end

  # PATCH/PUT /otpforms/1
  # PATCH/PUT /otpforms/1.json
  def update
    @otpform = Otpform.find(params[:id])
     
    @otpform.update_attributes(otpform_params)
    respond_to do |format|
      @customer = current_user.customers.where(mobile: @otpform.mobile).first 
      if(@otpform.otp_received==@customer.otpsent)
        
        @customer.update_attributes(verified: true)
        if ((@otpform.save) && (@customer.verified))
          format.html { redirect_to @otpform, notice:'Otpform was successfully created' }
          format.json { render :show, status: :created, location: @otpform }
        else
          
          format.html { render :new }
          format.json { render json: @otpform.errors, status: :unprocessable_entity }
        end
      else
        
        format.html { render :new, notice: 'Otpform has received unsuccessful parameters'}
        format.json { render json: @otpform.errors, status: :unprocessable_entity } 
      end
    end
  end

  # DELETE /otpforms/1
  # DELETE /otpforms/1.json
  def destroy
    @otpform.destroy
    respond_to do |format|
      format.html { redirect_to otpforms_url, notice: 'Otpform was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_otpform
      @otpform = Otpform.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def otpform_params
      params.require(:otpform).permit(:mobile, :otp_received,:user_id)
    end
end

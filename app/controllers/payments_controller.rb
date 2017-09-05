class PaymentsController < ::ApplicationController
  before_action :set_payment, only: [:show, :edit, :update, :destroy]

  before_action :set_return_to

  # GET /payments
  def index
    @payments = Payment.all
  end

  # GET /payments/1
  def show
  end

  # GET /payments/new
  def new
    @payment = Payment.new
    @payment.effect       = params[:effect]       if params[:effect].present?
    @payment.payable_type = params[:payable_type] if params[:payable_type].present?
    @payment.payable_id   = params[:payable_id]   if params[:payable_id].present?
  end

  # GET /payments/1/edit
  def edit
  end

  # POST /payments
  def create
    @payment = Payment.new(payment_params)

    if @payment.save
      redirect_to @return_to || @payment, notice: 'Payment was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /payments/1
  def update
    if @payment.update(payment_params)
      redirect_to @return_to || @payment, notice: 'Payment was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /payments/1
  def destroy
    @payment.destroy
    redirect_to payments_url, notice: 'Payment was successfully destroyed.'
  end

  # GET /pauyments/calculate_interest_and_penalty_values.js
  def calculate_interest_and_penalty_values
    @payment = Payment.new payment_params
    @payment.calculate_interest_and_penalty_values
  rescue => e
    @error = e.message
  end

  # GET /pauyments/calculate_payment_value.js
  def calculate_payment_value
    @payment = Payment.new payment_params
    @payment.calculate_payment_value
  rescue => e
    @error = e.message
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payment
      @payment = Payment.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def payment_params
      params.fetch(:payment, {}).permit(
        :effect,
        :description, 
        :due_date,
        :due_value,
        :payment_date,
        :payment_value,
        :interest_value,
        :penalty_value,
        :discount_value,
        :payable_id,
        :payable_type
      )
    end

    def set_return_to
      @return_to = params[:return_to]
      @return_to = false if @return_to.blank?
    end
end

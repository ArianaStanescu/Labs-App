class CreditCardsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_credit_card, only: %i[ show edit update destroy ]

  # GET /credit_cards or /credit_cards.json
  def index
    # @user = current_user
    # @credit_cards = @user.credit_cards

    credit_cards = CreditCard.includes(:user).all
    @credit_cards = credit_cards.where(user_id: current_user.id)
    @user = current_user
  end


  def show
    @credit_card = CreditCard.find(params[:id])
    if @credit_card.user_id != current_user.id
      redirect_to root_path, alert: 'You are not authorized to view this credit card.'
    end
  end

  # GET /credit_cards/new
  def new
    @credit_card = CreditCard.new
  end

  # GET /credit_cards/1/edit
  def edit
    @credit_card = CreditCard.find(params[:id])
    if @credit_card.user_id != current_user.id
      redirect_to root_path, alert: "You are not authorized to edit this credit card."
    end
  end

  # POST /credit_cards or /credit_cards.json
  def create
    @credit_card = CreditCard.new(credit_card_params)

    respond_to do |format|
      if @credit_card.save
        format.html { redirect_to credit_card_url(@credit_card), notice: "Credit card was successfully created." }
        format.json { render :show, status: :created, location: @credit_card }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @credit_card.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /credit_cards/1 or /credit_cards/1.json
  def update
    respond_to do |format|
      if @credit_card.update(credit_card_params)
        format.html { redirect_to credit_card_url(@credit_card), notice: "Credit card was successfully updated." }
        format.json { render :show, status: :ok, location: @credit_card }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @credit_card.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /credit_cards/1 or /credit_cards/1.json
  def destroy
    @credit_card.destroy

    respond_to do |format|
      format.html { redirect_to credit_cards_url, notice: "Credit card was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_credit_card
      @credit_card = CreditCard.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    # def credit_card_params
    #   params.fetch(:credit_card, {})
    # end

  def credit_card_params
    params.require(:credit_card).permit(:id, :number, :expiry_date, :user_id, :name, :cvv)
  end
end

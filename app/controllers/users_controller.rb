class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin, except: [:show]
  def index
    @users = User.all
  end
  # def new
  # end
  # def user_params
  #   params.require(:user).permit(:email, :password, :password_confirmation, credit_cards_attributes: [:number, :expiry_date])
  # end

  def show
    @user = current_user
    @credit_cards = current_user.credit_cards
    # if @user.address.nil?
    #   address = Address.create(user_id: @user.id)
    #   address.save
    #   @user.address = address
    # end
    @addresses = current_user.addresses
  end
end

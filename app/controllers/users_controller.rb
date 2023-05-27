class UsersController < ApplicationController

  before_action :check_admin
  def index
    @users = User.all
  end
  # def new
  # end
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, credit_cards_attributes: [:number, :expiry_date])
  end
end

class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin, except: [:show]
  include Pagy::Backend
  def index
    users = User.all
    @pagy, @users = pagy(users)
  end


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

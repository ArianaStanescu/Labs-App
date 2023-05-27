class Users2Controller < ApplicationController
  before_action :check_admin
  def index
    @users = User.all
  end
end

class Users2Controller < ApplicationController
  def index
    @users = User.all
  end
end

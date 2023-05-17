class HomeController < ApplicationController
  # def new
  # end

  def index
  end

  def all_products
    @products = Product.all
  end
end
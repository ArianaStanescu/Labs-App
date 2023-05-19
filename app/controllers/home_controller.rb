class HomeController < ApplicationController
  # def new
  # end

  def index
  end

  def all_products
    @products = Product.all
    @sort_order = params[:sort_order] || 'asc'
    @products = Product.order(price: @sort_order)
  end

end
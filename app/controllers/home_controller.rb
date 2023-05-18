class HomeController < ApplicationController
  # def new
  # end

  def index
  end

  def all_products
    @products = Product.all
    @sort_order = params[:sort_order] || 'asc' # Ordinea de sortare implicită este ascendentă
    @products = Product.order(price: @sort_order)
  end
end
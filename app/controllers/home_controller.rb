class HomeController < ApplicationController
  # def new
  # end

  def index
  end

  def all_products
    @sort_order = params[:sort_order] || 'asc'
    @products = Product.includes(image_attachment: :blob).order(price: @sort_order)

    # @products = Product.includes(image_attachment: :blob).all

    # @products = Product.all
    # @sort_order = params[:sort_order] || 'asc'
    # @products = Product.order(price: @sort_order)
  end

end
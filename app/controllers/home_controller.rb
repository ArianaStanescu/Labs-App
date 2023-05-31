class HomeController < ApplicationController
  before_action :authenticate_user!, except: [:index, :all_products]
  include Pagy::Backend
  # def new
  # end

  def index
  end

  def all_products
    @sort_order = params[:sort_order] || 'asc'
    # @products = Product.includes(image_attachment: :blob).order(price: @sort_order)
    @pagy, @products = pagy(Product.includes(image_attachment: :blob).order(price: @sort_order))
    # @products = Product.includes(image_attachment: :blob).all

    # @products = Product.all
    # @sort_order = params[:sort_order] || 'asc'
    # @products = Product.order(price: @sort_order)
  end

  def my_account
    @user = current_user
    @credit_cards = current_user.credit_cards
  end

end
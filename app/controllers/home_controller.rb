class HomeController < ApplicationController
  before_action :authenticate_user!, except: [:index, :all_products]
  include Pagy::Backend
  # def new
  # end

  def index
    @products = Product.where(id: [3, 6, 7, 26])
  end

  def all_products
    @sort_order = params[:sort_order] || 'asc'
    products= Product.includes(image_attachment: :blob).order(price: @sort_order)
    products = products.where(category_id: params[:category_id]) if params[:category_id].present?
    products = products.where(metal: params[:metal]) if params[:metal].present?
    products = products.where("name LIKE ? ", "%#{params[:search]}%") if params[:search].present?
    products = products.order(:name)
    # @pagy, @products = pagy(Product.includes(image_attachment: :blob).order(price: @sort_order), items:15)
    @pagy, @products = pagy(products, items:15)
    # @pagy, @products = pagy(Product.order(price: @sort_order), items:15)
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
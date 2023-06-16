class HomeController < ApplicationController
  before_action :authenticate_user!, except: [:index, :all_products]
  include Pagy::Backend
  # def new
  # end

  def index
    @products = Product.where(id: [3, 6, 7, 26])
  end

  def all_products

    if current_user.present?
      @wish_list_items = WishListItem.where(user_id: current_user.id)
    end

    products= Product.includes(image_attachment: :blob)
    products = products.where(category_id: params[:category_id]) if params[:category_id].present?
    products = products.where(metal: params[:metal]) if params[:metal].present?
    products = products.where("name LIKE ? ", "%#{params[:search]}%") if params[:search].present?

    if params[:sort_order] == 'asc'
      products = products.order(price: :asc)
    elsif params[:sort_order] == 'desc'
      products = products.order(price: :desc)
    end
    products = products.order(:name)

    @pagy, @products = pagy(products, items:15)

  end

  def my_account
    @user = current_user
    @credit_cards = current_user.credit_cards
  end

end
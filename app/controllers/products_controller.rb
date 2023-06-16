class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :check_admin , except: [:show]
  before_action :set_product, only: %i[ show edit update destroy ]
  # GET /products or /products.json
  include Pagy::Backend
  def index

    products = Product.includes(:category).all
    products = products.where(category_id: params[:category_id]) if params[:category_id].present?
    products = products.where(metal: params[:metal]) if params[:metal].present?
    products = products.where("name LIKE ? OR description LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%") if params[:search].present?

    if params[:sort_order] == 'asc'
      products = products.order(price: :asc)
    elsif params[:sort_order] == 'desc'
      products = products.order(price: :desc)
    end

    if params[:stock_order] == 'asc'
      products = products.order(stock: :asc)
    elsif params[:stock_order] == 'desc'
      products = products.order(stock: :desc)
    end

    products = products.order(:name)
    @pagy, @products = pagy(products)

  end

  # GET /products/1 or /products/1.json
  def show
    if current_user.present?
      @wish_list_items = WishListItem.where(user_id: current_user.id)
    end
    @wish_list_item_count = WishListItem.where(product_id: @product.id).distinct.count(:user_id)
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products or /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to product_url(@product), notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to product_url(@product), notice: "Product was successfully updated." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
  def product_params
    params.require(:product).permit(:id, :name, :description, :product_image, :sku, :stock, :metal, :size, :price, :category_id, :image)
  end
end

class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin, except: [:show, :create, :index]
  before_action :set_order, only: %i[ show edit update destroy ]
  include Pagy::Backend
  require 'securerandom'
  # GET /orders or /orders.json
  def index
    @user = current_user
    orders = Order.includes(:product, :user).all
    unless current_user.admin?
      orders = orders.where(user_id: current_user.id)
    end
    orders = orders.joins(:product).where(products: { category_id: params[:category_id] }) if params[:category_id].present?
    orders = orders.joins(:product).where(products: { metal: params[:metal] }) if params[:metal].present?
    orders = orders.joins(:product).where("products.name LIKE ?", "%#{params[:search]}%") if params[:search].present?
    @pagy, @orders = pagy(orders)



    # @orders = Order.includes(:product, :user).all
    # @user = current_user
    # if @user.role == "client"
    #   @orders = @user.orders
    # else
    #   @orders = Order.includes(:product, :user).all
    # end
    # @pagy, @orders = pagy(@orders)
  end

  # GET /orders/1 or /orders/1.json
  def show
    @user = current_user
    @order = Order.find(params[:id])
    if @order.user_id != current_user.id && current_user.role != 'admin'
      redirect_to root_path, alert: "You are not authorized to show this order."
    end
  end

  # GET /orders/new
  def new
    @order = Order.new
    @user = current_user
    if @user.role != 'admin'
      redirect_to root_path, alert: "You are not authorized."
    end
  end

  # GET /orders/1/edit
  def edit
    @user = current_user
    @order = Order.find(params[:id])
    # if @order.user_id != current_user.id
    if @user.role != 'admin'
      redirect_to root_path, alert: "You are not authorized to edit this order."
    end
  end

  # POST /orders or /orders.json
  def create
    @order = Order.new(order_params)
    respond_to do |format|
      if @order.save
        wish_list_item = current_user.wish_list_items.find_by(product_id: params[:order][:product_id])
        if wish_list_item.present?
          wish_list_item.destroy
        end
        product = @order.product
        product.update(stock: product.stock - 1)
        format.html { redirect_to order_url(@order), notice: "Order was successfully created." }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1 or /orders/1.json
  def update
    if current_user.role != 'admin'
      redirect_to root_path, alert: "You are not authorized."
    end
    respond_to do |format|
      # if @order.update(order_params)
      #   format.html { redirect_to order_url(@order), notice: "Order was successfully updated." }
      #   format.json { render :show, status: :ok, location: @order } order_params.present? &&
      if  @order.update(tracking_number:  generate_tracking_number, status: :shipped)
        # @order.tracking_number = generate_tracking_number
              format.html { redirect_to order_url(@order), notice: "Order was successfully shipped." }
              format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1 or /orders/1.json
  def destroy
    if current_user.role != 'admin'
      redirect_to root_path, alert: "You are not authorized."
    end
    @order.destroy

    respond_to do |format|
      format.html { redirect_to orders_url, notice: "Order was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
  def order_params
    params.require(:order).permit(:id, :user_id, :product_id, :status, :tracking_number, :quantity)
  end

  private
  def generate_tracking_number
    alphanumeric_characters = [*'0'..'9', *'A'..'Z']
    tracking_number = ""

    12.times do
      random_character = alphanumeric_characters.sample
      tracking_number += random_character
    end

    tracking_number
    # render json: { tracking_number: tracking_number }
  end


end

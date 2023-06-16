class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin, except: [:show, :create, :index]
  before_action :set_order, only: %i[ show edit update destroy ]
  include Pagy::Backend
  require 'securerandom'
  require "csv"
  require 'wicked_pdf'

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
    orders = orders.where(status: params[:status]) if params[:status].present?
    if params[:sort_by] == 'asc'
      orders = orders.order(created_at: :asc)
    elsif params[:sort_by] == 'desc'
      orders = orders.order(created_at: :desc)
    end
    @pagy, @orders = pagy(orders)

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

    if current_user.addresses.where(address_type: [Address.address_types[:shipping], Address.address_types[:both]]).empty? ||
      current_user.addresses.where(address_type: [Address.address_types[:billing], Address.address_types[:both]]).empty?
      redirect_to new_address_path, alert: "You need to add both a shipping address and a billing address before placing an order."
      return
    end

    if current_user.credit_cards.empty?
      redirect_to new_credit_card_path, alert: "You need to add a credit card before placing an order."
      return
    end

    respond_to do |format|
      if @order.save
        wish_list_item = current_user.wish_list_items.find_by(product_id: params[:order][:product_id])
        if wish_list_item.present?
          wish_list_item.destroy
        end
        product = @order.product
        product.update(stock: product.stock - 1)
        OrderMailer.send_email(current_user, @order).deliver_now
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
        OrderMailer.send_shipped_email(current_user, @order).deliver_now
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

  def generate_csv
    @orders = Order.all
    csv_data = CSV.generate do |csv|
      csv << ["Order ID", "User Email", "Product Name", "Quantity", "Tracking Number"]
      @orders.each do |order|
        csv << [order.id, order.user.email, order.product.name, order.quantity, order.tracking_number]
      end
    end
    send_data csv_data, filename: "orders.csv"
  end

  # def generate_pdf_invoice
  #   @user = current_user
  #   @order = Order.find(params[:id])
  #   @product = @order.product
  #   pdf = WickedPdf.new.pdf_from_string(
  #     render_to_string(
  #       # template: Rails.root.join('order_mailer', 'invoice_pdf.html.erb').to_s
  #       template: 'order_mailer/invoice_pdf'.to_s
  #     )
  #   )
  #   # pdf
  #   send_data pdf, filename: 'invoice.pdf', type: 'application/pdf', disposition: 'inline'
  # end

  # def generate_pdf
  #   @user = current_user
  #   @order = Order.find(params[:id])
  #
  #   respond_to do |format|
  #     format.pdf do
  #       pdf = WickedPdf.new.pdf_from_string(render_to_string(template: 'orders/generate_pdf'))
  #       send_data pdf, filename: "orders.pdf", type: "application/pdf", disposition: "inline"
  #     end
  #   end
  # end


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

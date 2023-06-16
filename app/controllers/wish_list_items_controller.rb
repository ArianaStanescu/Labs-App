class WishListItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_wish_list_item, only: %i[ show edit update destroy ]

  # GET /wish_list_items or /wish_list_items.json
  def index
    wish_list_items = WishListItem.includes(:product, :user).all
    @wish_list_items = wish_list_items.where(user_id: current_user.id)
  end

  # GET /wish_list_items/1 or /wish_list_items/1.json
  def show
    unless current_user.admin?
      redirect_to root_path, alert: 'You are not authorized.'
    end
  end

  # GET /wish_list_items/new
  def new
    unless current_user.admin?
      redirect_to root_path, alert: 'You are not authorized.'
    end
    redirect_to root_path, alert: 'You are not authorized.'
    @wish_list_item = WishListItem.new
  end

  # GET /wish_list_items/1/edit
  def edit
    # unless current_user.admin?
    #   redirect_to root_path, alert: 'You are not authorized.'
    # end
    redirect_to root_path, alert: 'You are not authorized.'
  end

  # POST /wish_list_items or /wish_list_items.json
  def create
    @wish_list_item = WishListItem.new(wish_list_item_params)

    respond_to do |format|
      if @wish_list_item.save
        # format.html { redirect_to wish_list_item_url(@wish_list_item), notice: "Item was successfully added to wish list." }
        format.html { redirect_to wish_list_items_path, notice: "Item was successfully added to the wish list." }
        format.json { render :show, status: :created, location: @wish_list_item }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @wish_list_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wish_list_items/1 or /wish_list_items/1.json
  def update
    unless current_user.admin?
      redirect_to root_path, alert: 'You are not authorized.'
    end
    respond_to do |format|
      if @wish_list_item.update(wish_list_item_params)
        format.html { redirect_to wish_list_item_url(@wish_list_item), notice: "Wish list item was successfully updated." }
        format.json { render :show, status: :ok, location: @wish_list_item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @wish_list_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wish_list_items/1 or /wish_list_items/1.json
  def destroy
    @wish_list_item.destroy

    respond_to do |format|
      format.html { redirect_to wish_list_items_url, notice: "Wish list item was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wish_list_item
      @wish_list_item = WishListItem.find_by(params[:id])
      # @wish_list_item = WishListItem.find(params[:id])

      if @wish_list_item.nil?
        flash[:alert] = "Wish List Item not found"
        redirect_to root_path
      end
    end

    # Only allow a list of trusted parameters through.
  def wish_list_item_params
    params.require(:wish_list_item).permit(:id, :user_id, :product_id)
  end
end

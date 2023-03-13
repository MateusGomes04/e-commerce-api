class CartItemsController < ApplicationController
  before_action :set_cart_item, only: %i[ show update destroy ]

  # GET /cart_items
  def index
    @cart_items = []
    if params[:cart_id].present?
      @cart_items = CartItem.joins(:cart).where(params[:cart_id])
    else 
      @cart_items = CartItem.all

    render json: @cart_items
    end
  end

  # GET /cart_items/1
  def show
    render json: @cart_item
  end

  # POST /cart_items
  def create
    @cart_item = CartItem.new(cart_item_params)

    if @cart_item.save
      render json: @cart_item, status: :created, location: @cart_item
    else
      render json: @cart_item.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /cart_items/1
  def update
    if @cart_item.update(cart_item_params)
      render json: @cart_item
    else
      render json: @cart_item.errors, status: :unprocessable_entity
    end
  end

  # DELETE /cart_items/1
  def destroy
    @cart_item.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart_item
      @cart_item = CartItem.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def cart_item_params
      params.require(:cart_item).permit(:quantity, :price_unit, :cart_id, :product_id)
    end
end

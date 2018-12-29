class MerchantsController < ApplicationController

  before_action :not_today_satan
  skip_before_action :not_today_satan, only: [:index]

  def index
    @merchants = User.merchants
    @top_sellers = User.merchants_by_revenue(:top, 3)
    @fast_merchants = User.merchants_by_fullfillment_time(:top, 3)
    @slow_merchants = User.merchants_by_fullfillment_time(:bottom, 3)
    @top_states = User.top_states(3)
    @top_cities = User.top_cities(3)
    @top_orders = Order.top_by_quantity(3) if Order.any_complete?
  end

  def show
    @merchant = current_user || User.find(session[:user_id])
    @top_5 = @merchant.top_5 if @merchant.orders
    @pending_orders = @merchant.pending_orders if @merchant.orders
  end

  def current_merchant?
    current_user && current_user.merchant?
  end

  def admin_or_merchant
    current_user.role == "merchant" || current_user.role == "admin"
  end

  def not_today_satan
    render_404 unless current_merchant?
  end

  def create
    thumbnail = params[:item][:thumbnail]

    File.open(Rails.root.join('app', 'assets', 'images', thumbnail.original_filename), 'wb') do |file|
      file.write(thumbnail.read)
    end

    @merchant = current_user
    @item = @merchant.items.create(item_params)
    redirect_to dashboard_items_path
  end

  def items_index
    @merchant = current_user
    @items = @merchant.items
  end

  def edit
    @item = Item.find(params[:item_id])
  end

  def destroy
    item = Item.find(params[:item_id])
    item.destroy
    redirect_to dashboard_items_path
  end

  def toggle_item
    item = Item.find(params[:item_id])
    item.toggle_enabled
    redirect_to dashboard_items_path
  end


  private

  def item_params
    thing = params[:item][:thumbnail].original_filename
    params[:item][:thumbnail] = thing
    params.require(:item).permit(:name, :description, :price, :thumbnail, :inventory)
  end
end

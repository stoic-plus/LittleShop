class MerchantsController < ApplicationController
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
  end
end

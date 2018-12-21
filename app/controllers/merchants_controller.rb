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
    if current_user 
      @merchant = current_user || User.find(session[:user_id]) 
    else 
      not_today_satan
    end
  end
  
  def current_merchant?
    current_user && current_user.merchant?
  end 

  def not_today_satan
    render file: "#{Rails.root}/public/404.html", status: :not_found unless current_merchant?
  end 
  

end

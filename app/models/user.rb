class User < ApplicationRecord
    validates_presence_of :name, :email, :role,
                          :address, :city, :zip, :state
    validates_presence_of :password, if: :password
    validates_inclusion_of :enabled, :in => [true, false]
    validates_uniqueness_of :email

  enum role: ["default", "merchant", "admin"]

    has_many :orders
    has_many :items
    has_secure_password

    def self.merchants
      where(role: 1)
    end

    def self.merchants_by_revenue(top_or_bottom, amount)
      order = top_or_bottom == :top ? "desc" : "asc"

      joins(items: :order_items)
        .where("order_items.fulfilled = true")
        .where(role: 1)
        .group(:id)
        .order("revenue #{order}")
        .limit(amount)
        .select("users.*, sum(order_items.price * order_items.quantity) as revenue")
    end

    def self.merchants_by_fullfillment_time(top_or_bottom, amount)
      order = top_or_bottom == :top ? "desc" : "asc"

      joins(items: :order_items)
        .where("order_items.fulfilled = true")
        .where(role: 1)
        .group(:id)
        .order("avg_f_time #{order}")
        .limit(amount)
        .select("users.*, avg(order_items.created_at - order_items.updated_at) as avg_f_time")
    end

    def self.top_states(amount = nil)
      top_cities_or_states(:state, amount)
    end

    def self.top_cities(amount = nil)
      top_cities_or_states(:city, amount)
    end

    def switch_enabled
      switch_boolean = !attributes["enabled"]
      update(enabled: switch_boolean)
    end

    private

    def self.top_cities_or_states(city_or_state, amount)
      if city_or_state == :city
        group = [:city, :state]
        selection = "city, state"
        order = "city asc, state asc"
      else
        group = :state
        selection = "state"
        order = "state asc"
      end

      select("#{selection}, count(orders.id) as order_count")
        .joins(:orders)
        .where("orders.status = ?", :complete)
        .group(group)
        .order("order_count desc, #{order}")
        .limit(amount)
    end

    def self.default
      User.where(role: "default")
    end
end

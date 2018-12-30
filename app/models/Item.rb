class Item < ApplicationRecord
  validates_presence_of :name, :description, :price, :inventory
  validates :price, :inventory, numericality: { greater_than: 0 }

  validates_inclusion_of :enabled, :in => [true, false]
  has_many :order_items, :dependent => :destroy
  has_many :orders, through: :order_items
  belongs_to :user

  def self.popular_items(top_or_bottom, amount)
      order = top_or_bottom == :top ? "desc" : "asc"

      joins(:order_items)
        .where("order_items.fulfilled = true")
        .group(:id)
        .order("item_count #{order}")
        .limit(amount)
        .select("items.*, sum(quantity) as item_count")
  end

  def self.return_inventory(items_and_quantities)
    items_and_quantities.each do |i_q|
      item = self.where(id: i_q.first).first
      item.update(inventory: item.inventory + i_q.last)
    end
  end

  def average_fulfillment_time
    results = ActiveRecord::Base.connection.execute("select avg(updated_at - created_at) as avg_f_time from order_items where item_id=#{self.id} and fulfilled='true'")
    if results.present? && results.first['avg_f_time']
      difference = results.first['avg_f_time']
      output = "#{difference[0..8]} hours #{difference[10..11]} minutes & #{difference[13..14]} seconds"
      return output
    else
      return nil
    end
  end

  def ordered?
    OrderItem.find_by(item: self)
  end

  def toggle_enabled
    self.enabled = !self.enabled
    save
  end 
end

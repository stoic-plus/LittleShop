class Order < ApplicationRecord
  validates_presence_of :status

  belongs_to :user

  has_many :order_items
  has_many :items, through: :order_items

  def self.top_by_quantity(amount = nil)
    joins(:order_items)
      .select("sum(order_items.quantity) as total_quantity")
      .where(status: "complete")
      .group(:id)
      .order("total_quantity desc")
      .limit(amount)
  end

  def self.any_complete?
    where(status: "complete").count > 0
  end
end

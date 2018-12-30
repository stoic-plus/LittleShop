require 'rails_helper'

describe Item, type: :model do
  describe "validations" do
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:description)}
    it {should validate_presence_of(:price)}
    it {should validate_presence_of(:inventory)}
    it {should validate_inclusion_of(:enabled).in_array([true,false])}
    it {should validate_numericality_of(:price)}
    it {should validate_numericality_of(:inventory)}
  end

  describe "relationships" do
    describe 'to orders' do
      it {should have_many(:order_items)}
      it {should have_many(:orders).through(:order_items)}
      it {should belong_to(:user)}
    end
  end
  describe "Class Methods" do
    it ".popular_items" do
      u_1 = create(:user)
      m_1 = create(:user, role: 1)
      o_1 = Order.create(status: "pending", user_id: u_1.id)
      i_1 = create(:item, price: 1, user_id: m_1.id)
      i_2 = create(:item, price: 1, user_id: m_1.id)
      i_3 = create(:item, price: 1, user_id: m_1.id)
      i_4 = create(:item, price: 1, user_id: m_1.id)
      i_5 = create(:item, price: 1, user_id: m_1.id)
      i_6 = create(:item, price: 1, user_id: m_1.id)

      OrderItem.create(
        quantity: 2,
        price: i_1.price,
        fulfilled: true,
        order_id: o_1.id,
        item_id: i_1.id,
        created_at: 10.days.ago,
        updated_at: 1.days.ago
      )

      OrderItem.create(
        quantity: 10,
        price: i_2.price,
        fulfilled: true,
        order_id: o_1.id,
        item_id: i_2.id,
        created_at: 10.days.ago,
        updated_at: 1.days.ago
      )
      OrderItem.create(
        quantity: 3,
        price: i_3.price,
        fulfilled: true,
        order_id: o_1.id,
        item_id: i_3.id,
        created_at: 10.days.ago,
        updated_at: 1.days.ago
      )
      OrderItem.create(
        quantity: 24,
        price: i_4.price,
        fulfilled: true,
        order_id: o_1.id,
        item_id: i_4.id,
        created_at: 10.days.ago,
        updated_at: 1.days.ago
      )
      OrderItem.create(
        quantity: 14,
        price: i_5.price,
        fulfilled: true,
        order_id: o_1.id,
        item_id: i_5.id,
        created_at: 10.days.ago,
        updated_at: 1.days.ago
      )
      OrderItem.create(
        quantity: 1,
        price: i_6.price,
        fulfilled: true,
        order_id: o_1.id,
        item_id: i_6.id,
        created_at: 10.days.ago,
        updated_at: 1.days.ago
      )

      expect(Item.popular_items(:top, 5)).to eq([i_4, i_5, i_2, i_3, i_1])
      expect(Item.popular_items(:bottom, 5)).to eq([i_6, i_1, i_3, i_2, i_5])
    end
    it '.return_inventory' do
      u = create(:user)
      m = create(:user, role: 1)

      o = create(:order, user: u)
      i_1 = create(:item, user: m)
      i_2 = create(:item, user: m)
      i_3 = create(:item, user: m)

      o_i_1 = create(:fulfilled_order_item, order: o, item: i_1)
      o_i_2 = create(:fulfilled_order_item, order: o, item: i_2)
      o_i_3 = create(:order_item, order: o, item: i_3)

      before_inventories = [i_1.inventory, i_2.inventory, i_3.inventory]
      items = [i_1, i_2, i_3]

      Item.return_inventory(
        [
          [o_i_1.item_id, o_i_1.quantity],
          [o_i_2.item_id, o_i_2.quantity],
          [o_i_3.item_id, o_i_3.quantity]
      ])

      items.each {|i| i.reload}
      expect(items[0].inventory).to eq(before_inventories[0] + o_i_1.quantity)
      expect(items[1].inventory).to eq(before_inventories[1] + o_i_2.quantity)
      expect(items[2].inventory).to eq(before_inventories[2] + o_i_3.quantity)
    end

    describe  'instance methods' do
      it '.avg_fulfillment_time' do
       u_1 = create(:user)

       m_1 = create(:user, role: 1)
       o_1 = Order.create(status: "pending", user_id: u_1.id)
       o_2 = Order.create(status: "pending", user_id: u_1.id)
       i_1 = create(:item, price: 1, user_id: m_1.id)

       OrderItem.create(
         quantity: 2,
         price: i_1.price,
         fulfilled: true,
         order_id: o_1.id,
         item_id: i_1.id,
         created_at: 10.days.ago,
         updated_at: 1.days.ago
       )

       OrderItem.create(
         quantity: 10,
         price: i_1.price,
         fulfilled: true,
         order_id: o_2.id,
         item_id: i_1.id,
         created_at: 5.days.ago,
         updated_at: 2.days.ago
       )

       expect(i_1.average_fulfillment_time).to eq("6 days 00 hours 00 minutes & 00 seconds")
    end    

      it '.ordered? - has the item been ordered?' do 
        user = create(:user)
        merchant = create(:user, role: 1)

        item1 = create(:item, user: merchant)
        item2 = create(:item, user: merchant)
        item3 = create(:item, user: merchant)
        
        order = create(:completed_order, user: user)
        order_item1 = create(:fulfilled_order_item, quantity: 2, price:2, item:item1, order: order)
        order_item2 = create(:fulfilled_order_item, quantity: 2, price:3, item:item2, order: order)

        expect(item1.ordered?).to be_truthy
        expect(item2.ordered?).to be_truthy
        expect(item3.ordered?).to_not be_truthy
      end

      it '.toggle_enabled' do
        merchant = create(:user, role: 1)
        item = create(:item, user: merchant)

        item.toggle_enabled

        expect(item.enabled).to eq(true) 

        item.toggle_enabled

        expect(item.enabled).to eq(false) 
      end
    end
  end
end

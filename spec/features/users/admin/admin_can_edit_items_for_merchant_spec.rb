require 'rails_helper'

describe 'As an admin when I visit a merchants items' do
  describe 'I have access to all functionality the merchant does' do
    it "can create and delete an item" do
      admin = create(:user, role: 2)
      merchant = create(:user, role: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_merchant_items_path(merchant)

      click_on 'add new item'

      expect(current_path).to eq(new_admin_merchant_item_path(merchant))

      fill_in "Name",	with: "Testing"
      fill_in "Description",	with: "123"
      fill_in "Price",	with: "11"
      fill_in "Inventory",	with: "456"
      click_on "Create Item"

      expect(current_path).to eq(admin_merchant_items_path(merchant))

      expect(page).to have_content("Testing")
      expect(page).to have_content("11")
      expect(page).to have_content("456")

      expect(page).to have_content("Item added!")

      item = Item.find_by(name: "Testing")

      within "#item-#{item.id}" do
        expect(page).to have_button("delete")
        click_button "delete"
      end
      
      expect(page).to have_content("Item successfully deleted!")
      
      item = Item.find_by(name: "Testing")

      expect(item).to_not be_truthy
    end
  end
end
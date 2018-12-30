require 'rails_helper'

describe "As a Merchant" do
  context "on dashboard/items i see" do
    xit "a link to create and see an item" do
      merchant = create(:user, role: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)

      visit dashboard_items_path

      click_on 'add new item'
      save_and_open_page
      expect(current_path).to eq(new_item_path)
      fill_in "Name",	with: "Testing"
      fill_in "Description",	with: "123"
      attach_file("Thumbnail", Rails.root.join('spec', 'test_image', 'oldguy.jpeg'))
      fill_in "Price",	with: "11"
      fill_in "Inventory",	with: "456"
      click_on "Create Item"

      expect(current_path).to eq(dashboard_items_path)
      expect(page).to have_content("Item added!")

      expect(page).to have_content("Testing")
      expect(page).to have_content("11")
      expect(page).to have_content("456")

      item = Item.find_by(name: "Testing")

      within "#item-#{item.id}" do
        expect(page).to have_button("delete")
        click_button "delete"
      end


      item = Item.find_by(name: "Testing")

      expect(item).to_not be_truthy
    end
  end
end

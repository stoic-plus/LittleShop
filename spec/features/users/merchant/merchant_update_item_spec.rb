require 'rails_helper'

describe "As a Merchant" do
  context "On /dashboard/items" do
    before :each do
      merchant = create(:user, role: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)
      @item = create(:item, user: merchant, thumbnail: "plant_10")
      visit dashboard_items_path
    end
    it "sees a link to edit and can edit images" do


      within "#item-#{@item.id}" do
        click_link "edit"
      end
      expect(current_path).to eq(edit_dashboard_item_path(@item))

      fill_in "Thumbnail", with: "plant_11"
      click_button "Update Item"

      @item.reload
      expect(current_path).to eq(dashboard_items_path)
      expect(page.find('#plant_11')['alt']).to match("Plant 11")
    end

    it "can update an image to be blank and will show default image" do
      within "#item-#{@item.id}" do
        click_link "edit"
      end

      fill_in "Thumbnail", with: ""
      click_button "Update Item"

      @item.reload

      expect(page.find('#no_img')['alt']).to match("No img")
    end
  end

  context "merchant updates item flash messages for each issue" do
    context 'merchant sees a flash message for each error' do
      it 'sees an error for missing name, description' do
        merchant = create(:user, role: 1)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)

        visit dashboard_items_path
        click_on 'add new item'

        fill_in "Price",	with: 11
        fill_in "Inventory",	with: 456
        click_on "Create Item"

        expect(page).to have_content("Name can't be blank")
        expect(page).to have_content("Description can't be blank")
      end

      it 'sees an error for missing price, inventory' do
        merchant = create(:user, role: 1)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)

        visit dashboard_items_path
        click_on 'add new item'

        fill_in "Name",	with: "blah"
        fill_in "Description",	with: "blah blah"
        click_on "Create Item"

        expect(page).to have_content("Price can't be blank")
        expect(page).to have_content("Inventory can't be blank")
      end
    end

    it 'shows flash messages if required fields are blank on update' do
      merchant = create(:user, role: 1)
      item = create(:item, user: merchant, thumbnail: "plant_10")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)

      visit dashboard_items_path

      within "#item-#{item.id}" do
        click_link "edit"
      end

      fill_in "Name", with: ""
      fill_in "Description", with: ""
      fill_in "Price", with: ""

      click_button "Update Item"

      item.reload

      expect(page).to have_content("name cannot be blank")
      expect(page).to have_content("description cannot be blank")
      expect(page).to have_content("price cannot be blank")
    end
  end
end

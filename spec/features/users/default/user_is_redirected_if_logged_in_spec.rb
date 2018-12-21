require 'rails_helper'

describe  'as a registered user' do
  context 'logged in as a default user' do
    it "should be redirected to profile page" do
      user_1 = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)
      visit login_path

      expect(current_path).to eq(profile_path)
      expect(page).to have_content("You are already logged in, silly.")
    end
  end
  context 'logged in as a merchant user' do
    it "should be redirected to merchant dashboard page" do
      merchant_1 = create(:user, role: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant_1)

      visit login_path

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("You are already logged in, silly.")
    end
  end
  context 'logged in as an admin user' do
    it "should be redirected to home page" do
      admin_1 = create(:user, role: 2)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin_1)

      visit login_path

      expect(current_path).to eq(root_path)
      expect(page).to have_content("You are already logged in, silly.")
    end
  end
end

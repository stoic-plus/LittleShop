describe 'admin can see specific links in the nav bar' do 
    it "can see specific admin links in the nav" do
        user = create(:user, name: "oh holy night", role:2)
        
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit merchants_path 

        within(".nav") do
            expect(page).to have_content("Profile")
            expect(page).to have_content("Orders")
            expect(page).to have_content("logout")
            expect(page).to have_content("Users") 
            expect(page).to_not have_content("shopping cart")
        end


        click_on('Profile')
        expect(current_path).to eq(profile_path)
        
        click_on('Orders')
        expect(current_path).to eq(profile_orders_path) 

        click_on('logout')
        expect(current_path).to eq(root_path)

        click_on('Users')
        expect(current_path).to eq(admin_users_path) 
    end

    it "can not see login or sign up" do 
        admin = create(:user, name: "oh holy night", role:2)
        
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

        visit admin_merchants_path

        expect(page).to_not have_content("login")  
        expect(page).to_not have_content("Sign Up")  
    end 

    it 'can see "sup, #{users name}"' do 
        admin = create(:user, name: "oh holy night", role:2)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
        
        visit admin_merchants_path

        expect(page).to have_content("Logged in as #{admin.name}")
    end 

    it "sad path - you can't see shit" do
        
        visit admin_merchants_path 
        
        within(".nav") do
            expect(page).to_not have_content("Profile")
            expect(page).to_not have_content("Orders")
            expect(page).to_not have_content("logout")
            expect(page).to_not have_content("Users")
        end

    end



end
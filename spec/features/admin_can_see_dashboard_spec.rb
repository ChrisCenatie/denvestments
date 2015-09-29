require "rails_helper"

feature "An admin logging in" do
  scenario "can see the admin dashboard" do
    User.create(username: "admin",
                password: "password",
                full_name: "Admin Adminerstein",
                address: "123 Admin Blvd, Admintown, USA",
                role: 1)

    visit "/"
    click_link("Log In")
    fill_in "user[username]", with: "admin"
    fill_in "user[password]", with: "password"
    click_button "Log In"

    expect(current_path).to eq("/admin/dashboard")
    expect(page).to have_content("admin")
  end
end

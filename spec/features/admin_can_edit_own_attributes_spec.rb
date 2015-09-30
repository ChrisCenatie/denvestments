require "rails_helper"

feature "Admin editing profile" do
  scenario "succeeds with valid attributes" do
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

    visit "/"
    click_link "admin"
    click_link "Edit My Profile"
    fill_in "admin[username]", with: "test username"
    fill_in "admin[password]", with: "test password"
    fill_in "admin[full_name]", with: "test full name"
    fill_in "admin[address]", with: "987 test address"
    click_on "Save Admin"

    expect(current_path).to eq("/admin/dashboard")
    expect(page).to have_content("Hello, TEST USERNAME!")
  end

  scenario "fails when not actually admin" do
    User.create(username: "user",
                password: "password",
                full_name: "User Userchwitz",
                address: "31415 User St, Userdom, USSR",
                role: 0)
    visit "/"
    click_link("Log In")
    fill_in "user[username]", with: "user"
    fill_in "user[password]", with: "password"
    click_button "Log In"

    visit "/"
    click_link "user"
    expect(page).not_to have_content("Edit My Profile")

    visit "/admin/edit"
    expect(page).to have_content("The page you were looking for doesn't exist")
  end
end

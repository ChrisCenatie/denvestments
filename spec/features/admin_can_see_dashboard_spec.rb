require "rails_helper"

feature "A visitor logging in" do
  scenario "can see the admin dashboard if admin" do
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

  scenario "can not see the admin dashboard if not an admin" do
    User.create(username: "alice",
                password: "password",
                full_name: "Alice Jones",
                address: "123 Main St.")
    visit "/"
    click_link ("Log In")
    fill_in "user[username]", with: "alice"
    fill_in "user[password]", with: "password"
    click_button "Log In"

    expect(current_path).to eq("/dashboard")

    visit "/admin/dashboard"
    expect(page).to have_content("The page you were looking for doesn't exist")
  end
end

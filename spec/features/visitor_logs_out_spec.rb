require "rails_helper"

feature "Logged in user" do
  scenario "can log out" do
    User.create(username: "alice", password: "password", full_name: "Alice Jones", address: "1500 Blake St., Denver, CO 80205")
    visit "/"
    click_link "Log In"
    fill_in "user[username]", with: "alice"
    fill_in "user[password]", with: "password"
    click_button "Log In"
    click_link "Log Out"

    expect(current_path).to eq("/")
    expect(page).to have_link("Log In")
    expect(page).to have_no_link("Log Out")
    expect(page).not_to have_content("alice")
  end
end

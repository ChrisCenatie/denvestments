require "rails_helper"

feature "Logged in user" do
  scenario "can log out" do
    User.create(username: "alice", password: "password")
    visit "/"
    click_link "login"
    fill_in "user[username]", with: "alice"
    fill_in "user[password]", with: "password"
    click_button "Log In"

    click_link "logout"
    expect(current_path).to eq("/")
    expect(page).to have_link("login")
    expect(page).to have_no_link("logout")
    expect(page).not_to have_content("alice")
  end
end

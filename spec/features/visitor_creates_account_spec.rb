require "rails_helper"

feature "Visitor creating account" do
  scenario "works with valid information" do
    visit "/"
    click_link "Create Account"
    fill_in "user[username]", with: "grant"
    fill_in "user[password]", with: "password"
    click_button "Submit"

    expect(current_path).to eq("/dashboard")
    expect(page).to have_content("grant")
    expect(page).to have_content("logout")
    expect(page).not_to have_content("Create Account")
    expect(page).not_to have_content("login")
  end

  scenario "won't work with invalid information" do
    User.create(username: "alice", password: "password")
    visit "/"
    click_link "Create Account"
    fill_in "user[username]", with: "alice"
    fill_in "user[password]", with: "password"
    click_button "Submit"

    expect(current_path).to eq("/register")
    expect(page).to have_content("Username has already been taken")
  end
end

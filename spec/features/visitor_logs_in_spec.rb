require "rails_helper"

feature "visitor logging in" do
  xscenario "correct login information" do
    User.create(
      username: "alice",
      password: "secret",
    )
    visit "/"
    click_link "login"
    fill_in "user[username]", with: "alice"
    fill_in "user[password]", with: "secret"
    click_button "Log In"

    expect(current_path).to be("/dashboard")
    within "#navbar" do
      expect(current_page).to have_content("alice")
      expect(current_page).to have_link("logout")
      expect(current_page).to have_no_link("login")
    end
  end
end

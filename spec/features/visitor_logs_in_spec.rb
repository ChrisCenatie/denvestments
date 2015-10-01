require "rails_helper"

feature "Visitor logging in" do
  include_context("features")

  scenario "works with correct login information" do
    log_in_as("alice", "password")
    expect(current_path).to eq("/dashboard")
    expect(page).to have_content("alice")
    visit "/"
    within ".navbar" do
      expect(page).to have_content("alice")
      expect(page).to have_link("Log Out")
      expect(page).to have_no_link("Log In")
    end
  end

  scenario "doesn't work with invalid login information" do
    log_in_as("notreal", "fakepassword")
    expect(current_path).to eq("/login")
    expect(page).to have_content("Incorrect login")
  end
end

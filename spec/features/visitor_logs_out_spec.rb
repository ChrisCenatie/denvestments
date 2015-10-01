require "rails_helper"

feature "Logged in user" do
  include_context("features")
  scenario "can log out" do
    log_in_as("alice", "password")
    click_link "Log Out"

    expect(current_path).to eq("/")
    expect(page).to have_link("Log In")
    expect(page).to have_no_link("Log Out")
    expect(page).not_to have_content("alice")
  end
end

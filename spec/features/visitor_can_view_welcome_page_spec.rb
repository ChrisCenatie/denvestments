require "rails_helper"

feature "visitor can visit welcome page" do
  scenario "and view content" do
    visit "/"
    expect(page).to have_content("Denvestments")
  end
end

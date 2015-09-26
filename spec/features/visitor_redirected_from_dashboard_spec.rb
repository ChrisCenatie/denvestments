require "rails_helper"

feature "Visitor visiting dashboard" do
  scenario "is redirected when not logged in" do
    visit "/dashboard"
    expect(current_path).to eq("/")
  end
end

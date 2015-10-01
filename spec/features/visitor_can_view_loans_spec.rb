require "rails_helper"

feature "visitor viewing loans" do
  include_context("features")

  scenario "can view loans" do
    visit "/loans"
    within(".header") do
      expect(page).to have_content("Loans")
    end
    within(".loans") do
      expect(page).to have_content("test title")
      expect(page).to have_content("test description")
      expect(page).to have_content("$50.00")
    end
  end
end

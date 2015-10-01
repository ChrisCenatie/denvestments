require "rails_helper"

feature "visitor can navigate to the loan show page" do
  include_context("features")

  scenario "without being logged in" do
    visit "/loans"
    click_on "test title"
    expect(current_path).to eq(loan_path(loan))
    expect(page).to have_content("test description")
    expect(page).to have_content("Price: $50.00")
    expect(page).to have_selector(:link_or_button, "Add to Cart")
    expect(page).to_not have_content("other test description")
  end
end

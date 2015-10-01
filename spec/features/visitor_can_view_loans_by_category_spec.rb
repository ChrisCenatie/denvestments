require "rails_helper"

feature "visitor can view loans by category" do
  include_context("features")

  scenario "from the navbar menu" do
    visit "/loans"
    click_on "Categories"
    click_on "Test Category"

    expect(current_path).to eq(category_path(category))

    within(".header") do
      expect(page).to have_content("Test Category")
    end
    within(".loans") do
      expect(page).to have_content("test title")
      expect(page).to have_content("test description")
      expect(page).to have_content("$50.00")

      expect(page).to_not have_content("other test description")
    end
  end

  scenario "from the category index" do
    visit "/categories/#{category.id}"
    within(".header") do
      expect(page).to have_content("Test Category")
    end
    within(".loans") do
      expect(page).to have_content("test title")
      expect(page).to have_content("test description")
      expect(page).to have_content("$50.00")

      expect(page).to_not have_content("other test description")
    end
  end
end

require "rails_helper"

feature "visitor edits loan quantity in cart" do
  include_context("features")

  scenario "by increasing loan quantity without being logged in" do
    visit "/"
    click_link("Loans")

    within(".loans") do
      first(".caption").click_button("Add to Cart")
    end

    expect(page).to have_content("Loans in Cart: 1")
    page.find("#cart").click
    within(".items") do
      expect(page).to have_content("test title")
      expect(page).to have_content("test description")
      expect(page).to have_content("Total Price: $50.00")
    end
    within(".quantity") do
      fill_in "Quantity", with: 2
      click_on("Change Quantity")
    end

    expect(current_path).to eq("/cart")
    within(".items") do
      expect(page).to have_content("Total Price: $100.00")
    end
  end

  scenario "by decreasing loan quantity without being logged in" do
    visit "/"
    click_link("Loans")

    within(".loans") do
      first(".caption").click_button("Add to Cart")
      first(".caption").click_button("Add to Cart")
    end

    expect(page).to have_content("Loans in Cart: 2")
    page.find("#cart").click
    within(".items") do
      expect(page).to have_content("test title")
      expect(page).to have_content("test description")
      expect(page).to have_content("Total Price: $100.00")
    end
    within(".quantity") do
      fill_in "Quantity", with: 1
      click_on("Change Quantity")
    end

    expect(current_path).to eq("/cart")
    within(".items") do
      expect(page).to have_content("Total Price: $50.00")
    end
  end
end

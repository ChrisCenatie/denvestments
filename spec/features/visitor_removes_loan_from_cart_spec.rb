require "rails_helper"

feature "visitor removes loan from cart" do
  include_context("features")

  scenario "without being logged in" do
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

    click_button("Remove Loan")

    expect(current_path).to eq("/cart")
    expect(page).to have_content("Total Price: $0.00")

    within(".alert-success") do
      result = "Successfully removed test title from your cart."
      expect(page).to have_content(result)
    end

    click_link("test title")

    expect(current_path).to eq("/loans/#{loan.id}")
  end
end

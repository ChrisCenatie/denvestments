require "rails_helper"

feature "visitor edits loan quantity in cart" do
  scenario "by increasing loan quantity without being logged in" do
    Loan.create(title: "Kitten Mittens",
                description: "Support your kittens!",
                price: 50,
                avatar: File.open("bird.jpg", "rb"))
    visit "/"
    click_link("Loans")

    within(".loans") do
      click_button("Add to Cart")
    end

    expect(page).to have_content("Loans in Cart: 1")
    page.find("#cart").click
    within(".items") do
      expect(page).to have_content("Kitten Mittens")
      expect(page).to have_content("Support your kittens!")
      expect(page).to have_content("Total Price: 50")
      # expect(page).to have_css("img")
    end
    within(".quantity") do
      select 2, from: "Quantity"
      click_on("Change Quantity")
    end

    expect(current_path).to eq("/cart")
    within(".items") do
      # expect(page).to have_select("Quantity", selected: 2)
      expect(page).to have_content("Total Price: 100")
    end
  end

  scenario "by decreasing loan quantity without being logged in" do
    Loan.create(title: "Kitten Mittens",
                description: "Support your kittens!",
                price: 50,
                avatar: File.open("bird.jpg", "rb"))
    visit "/"
    click_link("Loans")

    within(".loans") do
      click_button("Add to Cart")
      click_button("Add to Cart")
    end

    expect(page).to have_content("Loans in Cart: 2")
    page.find("#cart").click
    within(".items") do
      expect(page).to have_content("Kitten Mittens")
      expect(page).to have_content("Support your kittens!")
      expect(page).to have_content("Total Price: 100")
      # expect(page).to have_css("img")
    end
    within(".quantity") do
      select 1, from: "Quantity"
      click_on("Change Quantity")
    end

    expect(current_path).to eq("/cart")
    within(".items") do
      # expect(page).to have_select("Quantity", selected: 2)
      expect(page).to have_content("Total Price: 50")
    end
  end
end

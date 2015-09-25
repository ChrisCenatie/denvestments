require "rails_helper"

feature "visitor adds loans to shopping cart" do
  scenario "without being logged in" do
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
    page.find("#cart").click
    within(".total") do
      expect(page).to have_content("Kitten Mittens")
      expect(page).to have_content("Support your kittens!")
      expect(page).to have_content("Total Price: $100.00")
      expect(page).to have_css("img")
    end
  end
end

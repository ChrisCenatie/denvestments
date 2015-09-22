require "rails_helper"

feature "visitor viewing loans" do
  scenario "can view loans" do
    Loan.create(title: "Kitten Mittens",
                description: "Support your kittens!",
                price: 50,
                avatar: File.open("bird.jpg", "rb"))
    visit "/loans"

    within(".header") do
      expect(page).to have_content("Loans")
    end
    within(".loans") do
      expect(page).to have_content("Kitten Mittens")
      expect(page).to have_content("Support your kittens!")
      expect(page).to have_content("50")
      expect(page).to have_css("img")
    end
  end
end

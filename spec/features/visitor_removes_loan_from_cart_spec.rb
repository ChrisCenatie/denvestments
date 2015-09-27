require "rails_helper"

feature "visitor removes loan from cart" do
  scenario "without being logged in" do
    loan = Loan.create(title: "Kitten Mittens",
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

    click_button("Remove Loan")

    expect(current_path).to eq("/cart")
    expect(page).to have_content("Total Price: 0")

    within(".delete_message") do
      result = "Successfully removed Kitten Mittens from your cart."
      expect(page).to have_content(result)
    end

    click_link("Kitten Mittens")

    expect(current_path).to eq("/loans/#{loan.id}")
  end
end

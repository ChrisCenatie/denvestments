require "rails_helper"

feature "visitor adds loans to shopping cart" do
  scenario "without being logged in from the loans index page" do
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
  end

  scenario "without being logged in from the category show page" do
    loan = Loan.create(title: "Kitten Mittens",
                       description: "Support your kittens!",
                       price: 5,
                       avatar: File.open("bird.jpg", "rb"))
    category = Category.create(name: "Crafts")
    category.loans << loan
    visit "/"
    click_on "Categories"
    click_on "Crafts"
    within(".loans") do
      click_button("Add to Cart")
    end
    expect(page).to have_content("Loans in Cart: 1")
    expect(current_path).to eq "/categories/#{category.id}"
    page.find("#cart").click
    within(".items") do
      expect(page).to have_content("Kitten Mittens")
      expect(page).to have_content("Support your kittens!")
      expect(page).to have_content("Total Price: 5")
      # expect(page).to have_css("img")
    end
  end

  scenario "without being logged in from the loan show page" do
    loan = Loan.create(title: "Kitten Mittens",
                       description: "Support your kittens!",
                       price: 5,
                       avatar: File.open("bird.jpg", "rb"))

    visit "/loans/#{loan.id}"
    click_button("Add to Cart")

    expect(page).to have_content("Loans in Cart: 1")
    expect(current_path).to eq "/loans/#{loan.id}"
    page.find("#cart").click
    within(".items") do
      expect(page).to have_content("Kitten Mittens")
      expect(page).to have_content("Support your kittens!")
      expect(page).to have_content("Total Price: 5")
      # expect(page).to have_css("img")
    end
  end
end

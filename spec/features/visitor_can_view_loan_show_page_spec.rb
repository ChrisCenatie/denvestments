require "rails_helper"

feature "visitor can navigate to the loan show page" do
  scenario "without being logged in" do
    @loan = Loan.create(title: "Urban Bees",
                        description: "Buy local Denver honey.",
                        price: 50)
    Loan.create(title: "Kitten Mittens",
                description: "Support your local kittens.",
                price: 50)

    visit "/loans"
    click_on "Urban Bees"
    expect(current_path).to eq(loan_path(@loan))
    expect(page).to have_content("Buy local Denver honey.")
    expect(page).to have_content("Price: 50")
    expect(page).to have_selector(:link_or_button, "Add to Cart")
    expect(page).to_not have_content("Support your local kittens.")
  end
end

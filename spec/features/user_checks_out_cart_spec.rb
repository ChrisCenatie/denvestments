require "rails_helper"

feature "User checks out cart" do
  scenario "with valid inputs" do
    user = User.create(username: "Chris",
                       password: "password",
                       full_name: "Chris C",
                       address: "901 Sherman")
    category = Category.create( name: "Cat Stuff")
    loan = Loan.create(title: "Kitten Mittens",
                       description: "Everyone needs them!",
                       price: 100.5,
                       category_id: category.id)
    visit "/loans"
    within(".loans") do
      click_button("Add to Cart")
    end
    visit(login_path)
    fill_in "Username", with: "Chris"
    fill_in "Password", with: "password"
    click_button("Log In")
    expect(current_path).to eq "/dashboard"
    page.find("#cart").click
    expect(current_path).to eq "/cart"
    click_link("Checkout")
    expect(current_path).to  eq new_order_path

    within("#payment") do
      fill_in "order[card_number]", with: "1234 1234 1234 1234"
      fill_in "order[card_expiration]", with: "10/20"
      click_button("Submit Order")
    end
    
    expect(current_path).to eq order_path(Order.last.id)
    expect(page).to have_content("Loans in Cart: 0")
    expect(page).to have_content("Order successful!")
    expect(page).to have_content("Kitten Mittens")
    expect(page).to have_content("1")
    expect(page).to have_content("Total Paid: $100.50")
  end

  # scenario "visitor must login to checkout"do
  #
  # end

  # scenario "user must enter valid information"
  # end
end

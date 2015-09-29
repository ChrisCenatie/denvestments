require "rails_helper"

feature "User checks out cart" do
  scenario "with valid inputs" do
    user = User.create(username: "Chris",
                       password: "password",
                       full_name: "Chris C",
                       address: "901 Sherman")
    loan = Loan.create(title: "Kitten Mittens",
                       description: "Everyone needs them!",
                       price: 100.5)
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
    click_button("Checkout")
    expect(current_path).to  eq new_user_order_path
    within("#payment") do
      fill_in "Credit Card No.", with: "1234 1234 1234 1234"
      fill_in "Expiration Date", with: "10/20"
      click_button("Submit Order")
    end
    expect(current_path).to user_order_path(Order.last.id)
    expect(page).to have_content("Loans in Cart: 0")
    expect(page).to have_content("Order successful!")
    expect(page).to have_content("Kitten Mittens")
    expect(page).to have_content("Order Quantity: 1")
    expect(page).to have_content("Amount Paid: $100.50")
  end

  # scenario "visitor must login to checkout"do
  #
  # end

  # scenario "user must enter valid information"
  # end
end

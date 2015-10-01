require "rails_helper"

feature "User checks out cart" do
  scenario "with valid inputs" do
    User.create(username: "Chris",
                password: "password",
                full_name: "Chris C",
                address: "1510 Blake")
    category = Category.create(name: "Cat Stuff")
    Loan.create(title: "Kitten Mittens",
                description: "Everyone needs them!",
                price: 100.5,
                category_id: category.id)
    Loan.create(title: "Kitten Socks",
                description: "For your feet!",
                price: 50.0,
                category_id: category.id)
    visit "/loans"
    click_link("Kitten Mittens")
    click_button("Add to Cart")
    visit "/loans"
    click_link("Kitten Socks")
    click_button("Add to Cart")
    visit(login_path)
    fill_in "Username", with: "Chris"
    fill_in "Password", with: "password"
    click_button("Log In")
    expect(current_path).to eq "/dashboard"
    page.find("#cart").click
    expect(current_path).to eq "/cart"
    click_link("Checkout")
    expect(current_path).to eq new_order_path

    within("#payment") do
      fill_in "order[card_number]", with: "1234 1234 1234 1234"
      fill_in "order[card_expiration]", with: "10/20"
      click_button("Submit Order")
    end

    expect(current_path).to eq order_path(Order.last.id)
    expect(page).to have_content("Loans in Cart: 0")
    expect(page).to have_content("Chris C")
    expect(page).to have_content("1510 Blake")
    expect(page).to have_content(Order.last.date)
    expect(page).to have_content("Order successful!")
    expect(page).to have_content("Kitten Mittens")
    expect(page).to have_content("Kitten Socks")
    expect(page).to have_content("$100.50")
    expect(page).to have_content("$50.00")
    expect(page).to have_content("Status: Ordered")
    expect(page).to have_content("Total: $150.50")
  end

  scenario "visitor must login to checkout"do
    User.create(username: "Chris",
                password: "password",
                full_name: "Chris C",
                address: "901 Sherman")
    category = Category.create(name: "Cat Stuff")
    Loan.create(title: "Kitten Mittens",
                description: "Everyone needs them!",
                price: 100.5,
                category_id: category.id)
    visit "/loans"
    within(".loans") do
      click_button("Add to Cart")
    end
    page.find("#cart").click
    expect(current_path).to eq "/cart"
    click_link("Checkout")

    expect(current_path).to eq login_path
    message = "Please Login or Create an Account to Checkout"
    expect(page).to have_content(message)
    fill_in "Username", with: "Chris"
    fill_in "Password", with: "password"
    click_button("Log In")
    page.find("#cart").click
    expect(current_path).to eq "/cart"
    click_link("Checkout")
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
    expect(page).to have_content("Total: $100.50")
  end

  scenario "visitor can not see other users orders" do
    user = User.create(username: "Jimothy",
                       password: "password",
                       full_name: "Chris C",
                       address: "901 Sherman")
    category = Category.create(name: "Cat Stuff")
    loan = Loan.create(title: "Kitten Mittens",
                       description: "Everyone needs them!",
                       price: 100.5,
                       category_id: category.id)
    order = Order.create(user_id: user.id,
                         card_number: "1234",
                         card_expiration: "09/10",
                         total_cost: 100.50,
                         status: "Ordered")
    OrderItem.create(loan_id: loan.id,
                     quantity: 1,
                     order_id: order.id)
    visit order_path(order.id)

    expect(page).to have_content("doesn't exist")
  end

  scenario "another user can not see other users orders" do
    user = User.create(username: "Jimothy",
                       password: "password",
                       full_name: "Chris C",
                       address: "901 Sherman")
    category = Category.create(name: "Cat Stuff")
    loan = Loan.create(title: "Kitten Mittens",
                       description: "Everyone needs them!",
                       price: 100.5,
                       category_id: category.id)
    order = Order.create(user_id: user.id,
                         card_number: "1234",
                         card_expiration: "09/10",
                         total_cost: 100.50,
                         status: "Ordered")
    OrderItem.create(loan_id: loan.id,
                     quantity: 1,
                     order_id: order.id)
    User.create(username: "Chris",
                password: "password",
                full_name: "Bob C",
                address: "9 Sherman")
    visit "/login"
    fill_in "Username", with: "Chris"
    fill_in "Password", with: "password"
    click_button("Log In")
    visit order_path(order.id)

    expect(page).to have_content("doesn't exist")
  end

  scenario "admin user can see other users orders" do
    user = User.create(username: "Jimothy",
                       password: "password",
                       full_name: "Chris C",
                       address: "901 Sherman")
    category = Category.create(name: "Cat Stuff")
    loan = Loan.create(title: "Kitten Mittens",
                       description: "Everyone needs them!",
                       price: 100.5,
                       category_id: category.id)
    order = Order.create(user_id: user.id,
                         card_number: "1234",
                         card_expiration: "09/10",
                         total_cost: 100.50,
                         status: "Ordered")
    OrderItem.create(loan_id: loan.id,
                     quantity: 1,
                     order_id: order.id)
    User.create(username: "Chris",
                password: "password",
                full_name: "Bob C",
                address: "9 Sherman",
                role: 1)
    visit "/login"
    fill_in "Username", with: "Chris"
    fill_in "Password", with: "password"
    click_button("Log In")
    visit order_path(order.id)

    expect(current_path).to eq order_path(Order.last.id)
    expect(page).to have_content("Loans in Cart:")
    expect(page).to have_content("Kitten Mittens")
    expect(page).to have_content("1")
    expect(page).to have_content("Total: $100.50")
  end
end

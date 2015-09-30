require "rails_helper"

feature "A visitor logging in" do
  scenario "can see the admin dashboard if admin" do
    User.create(username: "admin",
                password: "password",
                full_name: "Admin Adminerstein",
                address: "123 Admin Blvd, Admintown, USA",
                role: 1)

    visit "/"
    click_link("Log In")
    fill_in "user[username]", with: "admin"
    fill_in "user[password]", with: "password"
    click_button "Log In"

    expect(current_path).to eq("/admin/dashboard")
    expect(page).to have_content("Admin Dashboard")
  end

  scenario "can not see the admin dashboard if not an admin" do
    User.create(username: "alice",
                password: "password",
                full_name: "Alice Jones",
                address: "123 Main St.")
    visit "/"
    click_link ("Log In")
    fill_in "user[username]", with: "alice"
    fill_in "user[password]", with: "password"
    click_button "Log In"

    expect(current_path).to eq("/dashboard")

    visit "/admin/dashboard"
    expect(page).to have_content("The page you were looking for doesn't exist")
  end

  scenario "can see all orders on dashboard if admin" do
    User.create(username: "admin",
                password: "password",
                full_name: "Admin Adminerstein",
                address: "123 Admin Blvd, Admintown, USA",
                role: 1)
    user = User.create(username: "Chris",
                       password: "password",
                       full_name: "Bob C",
                       address: "9 Sherman",
                       role: 1)
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
    visit "/"
    click_link("Log In")
    fill_in "user[username]", with: "admin"
    fill_in "user[password]", with: "password"
    click_button "Log In"
    click_button "Ordered"
    expect(page).to have_content("Order ID: #{order.id}")
    expect(page).to have_content("Ordered - 1")
  end

  scenario "can update ordered status to cancelled if admin" do
    User.create(username: "admin",
                password: "password",
                full_name: "Admin Adminerstein",
                address: "123 Admin Blvd, Admintown, USA",
                role: 1)
    user = User.create(username: "Chris",
                       password: "password",
                       full_name: "Bob C",
                       address: "9 Sherman",
                       role: 1)
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
    visit "/"
    click_link("Log In")
    fill_in "user[username]", with: "admin"
    fill_in "user[password]", with: "password"
    click_button "Log In"
    click_button("Ordered")
    click_link("Cancel")
    click_button("Cancelled")
    within("#Cancelled") do
      expect(page).to have_content(order.id)
      expect(page).to have_content("Cancelled - 1")
    end
  end

  scenario "can update ordered status to paid if admin" do
    User.create(username: "admin",
                password: "password",
                full_name: "Admin Adminerstein",
                address: "123 Admin Blvd, Admintown, USA",
                role: 1)
    user = User.create(username: "Chris",
                       password: "password",
                       full_name: "Bob C",
                       address: "9 Sherman",
                       role: 1)
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
    visit "/"
    click_link("Log In")
    fill_in "user[username]", with: "admin"
    fill_in "user[password]", with: "password"
    click_button "Log In"
    click_button("Ordered")
    click_link("Mark as Paid")
    click_button("Paid")
    within("#Paid") do
      expect(page).to have_content(order.id)
      expect(page).to have_content("Paid - 1")
    end
  end

  scenario "can update paid order status to cancelled if admin" do
    User.create(username: "admin",
                password: "password",
                full_name: "Admin Adminerstein",
                address: "123 Admin Blvd, Admintown, USA",
                role: 1)
    user = User.create(username: "Chris",
                       password: "password",
                       full_name: "Bob C",
                       address: "9 Sherman",
                       role: 1)
    category = Category.create(name: "Cat Stuff")
    loan = Loan.create(title: "Kitten Mittens",
                       description: "Everyone needs them!",
                       price: 100.5,
                       category_id: category.id)
    order = Order.create(user_id: user.id,
                         card_number: "1234",
                         card_expiration: "09/10",
                         total_cost: 100.50,
                         status: "Paid")
    OrderItem.create(loan_id: loan.id,
                     quantity: 1,
                     order_id: order.id)
    visit "/"
    click_link("Log In")
    fill_in "user[username]", with: "admin"
    fill_in "user[password]", with: "password"
    click_button "Log In"
    click_button("Paid")
    click_link("Cancel")
    click_button("Cancelled")
    within("#Cancelled") do
      expect(page).to have_content(order.id)
      expect(page).to have_content("Cancelled - 1")
    end
  end

  scenario "can update paid order status to completed if admin" do
    User.create(username: "admin",
                password: "password",
                full_name: "Admin Adminerstein",
                address: "123 Admin Blvd, Admintown, USA",
                role: 1)
    user = User.create(username: "Chris",
                       password: "password",
                       full_name: "Bob C",
                       address: "9 Sherman",
                       role: 1)
    category = Category.create(name: "Cat Stuff")
    loan = Loan.create(title: "Kitten Mittens",
                       description: "Everyone needs them!",
                       price: 100.5,
                       category_id: category.id)
    order = Order.create(user_id: user.id,
                         card_number: "1234",
                         card_expiration: "09/10",
                         total_cost: 100.50,
                         status: "Paid")
    OrderItem.create(loan_id: loan.id,
                     quantity: 1,
                     order_id: order.id)
    visit "/"
    click_link("Log In")
    fill_in "user[username]", with: "admin"
    fill_in "user[password]", with: "password"
    click_button "Log In"
    click_button("Paid")
    click_link("Mark as Completed")
    click_button("Completed")
    within("#Completed") do
      expect(page).to have_content(order.id)
      expect(page).to have_content("Completed - 1")
    end
  end
end

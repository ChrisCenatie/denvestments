shared_context "features" do
  let!(:admin) do
    User.create(username: "admin",
                password: "password",
                full_name: "Admin Adminerstein",
                address: "123 Admin Blvd, Admintown, USA",
                role: 1)
  end

  let!(:user) do
    User.create(username: "alice",
                password: "password",
                full_name: "Alice Smith",
                address: "123 Main St. Anytown, USA",
                role: 0)
  end

  let!(:category) do
    Category.create(name: "Test Category")
  end

  let!(:other_category) do
    Category.create(name: "Other Category")
  end

  let!(:loan) do
    Loan.create(title: "test title",
                       description: "test description",
                       price: 50,
                       category: category)
  end

  let!(:other_loan) do
    Loan.create(title: "other test title",
                             description: "other test description",
                             price: 75,
                             category: other_category)
  end

  let!(:order) do
    order = Order.create(user_id: user.id,
                         card_number: "1234",
                         card_expiration: "09/10",
                         total_cost: 100.50,
                         status: "Ordered")
  end

  let!(:order_item) do
    OrderItem.create(loan_id: loan.id,
                     quantity: 1,
                     order_id: order.id)
  end

  def log_in_as(username, password)
    visit "/"
    click_link("Log In")
    fill_in "user[username]", with: username
    fill_in "user[password]", with: password
    click_button "Log In"
  end
end

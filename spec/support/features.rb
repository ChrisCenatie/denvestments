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

  let!(:loan) do
    category = Category.create(name: "test category")
    loan = Loan.create(title: "test title",
                       description: "test description",
                       price: 50,
                       category: category)
  end

  def log_in_as(username, password)
    visit "/"
    click_link("Log In")
    fill_in "user[username]", with: username
    fill_in "user[password]", with: password
    click_button "Log In"
  end
end

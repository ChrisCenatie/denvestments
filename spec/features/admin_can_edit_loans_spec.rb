require "rails_helper"

feature "Admin viewing loans" do
  scenario "can edit loans" do
    User.create(username: "admin",
                password: "password",
                full_name: "Admin Adminerstein",
                address: "123 Admin Blvd, Admintown, USA",
                role: 1)
    category = Category.create(name: "test category")
    loan = Loan.create(title: "test title",
                       description: "test description",
                       price: 50,
                       category: category)
    visit "/"
    click_link("Log In")
    fill_in "user[username]", with: "admin"
    fill_in "user[password]", with: "password"
    click_button "Log In"

    visit "/admin/loans"
    click_on("Edit")
    expect(current_path).to eq("/admin/loans/#{loan.id}/edit")
    fill_in "loan[title]", with: "other test"
    fill_in "loan[description]", with: "other test description"
    fill_in "loan[price]", with: "60"
    fill_in "loan[status]", with: "Active"
    click_on("Submit")
    expect(current_path).to eq(loan_path(loan))
    expect(page).to have_content("other test")
    expect(page).to have_content("other test description")
  end
end

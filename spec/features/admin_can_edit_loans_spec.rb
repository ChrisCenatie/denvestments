require "rails_helper"

feature "Admin viewing loans" do
  scenario "can edit loans" do
    User.create(username: "admin",
                password: "password",
                full_name: "Admin Adminerstein",
                address: "123 Admin Blvd, Admintown, USA",
                role: 1)
    Loan.create(title: "test",
                description: "test",
                price: 50,
                category: Category.create(name: "test"))
    visit "/"
    click_link("Log In")
    fill_in "user[username]", with: "admin"
    fill_in "user[password]", with: "password"
    click_button "Log In"

    visit "/admin/loans"
    click_on("Edit")
    expect(current_path).to eq("/admin/loan/1/edit")
    fill_in "loan[title]", with: "other test"
    fill_in "loan[description]", with: "other test description"
    fill_in "loan[status]", with: "Out of stock"
  end
end

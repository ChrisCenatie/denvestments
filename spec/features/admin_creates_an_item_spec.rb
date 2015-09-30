require "rails_helper"

feature "User creating loan" do
  include_context "features"

  scenario "without image succeeds while logged in as admin" do
    log_in_as("admin", "password")

    click_link("View Loans")
    click_link("Create Loan")
    fill_in "loan[title]", with: "Test loan"
    fill_in "loan[description]", with: "Coming to a theater near you!"
    fill_in "loan[price]", with: 50
    select "Test Category", from: "loan[category_id]"
    click_button("Create Loan")

    expect(current_path).to eq("/admin/loans")
    expect(page).to have_content("Test loan")
    expect(page).to have_content("Coming to a theater near you!")
    expect(page).to have_content("$50.00")
  end

  scenario "fails with incorrect attributes" do
    visit "/"
    click_link("Log In")
    fill_in "user[username]", with: "admin"
    fill_in "user[password]", with: "password"
    click_button "Log In"

    click_link("View Loans")
    click_link("Create Loan")
    fill_in "loan[description]", with: "Coming to a theater near you!"
    fill_in "loan[price]", with: 50
    select "Test Category", from: "loan[category_id]"
    click_button("Create Loan")

    expect(current_path).to eq("/admin/loans/new")
    expect(page).to have_content("Title can't be blank")
  end
end

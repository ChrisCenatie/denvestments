require "rails_helper"

feature "Admin viewing loans" do
  include_context "features"

  scenario "can edit loans" do
    other_category = Category.create(name: "other category")
    log_in_as("admin", "password")
    visit "/admin/loans"
    click_on("Edit")
    expect(current_path).to eq("/admin/loans/#{loan.id}/edit")
    fill_in "loan[title]", with: "other test"
    fill_in "loan[description]", with: "other test description"
    fill_in "loan[price]", with: "60"
    fill_in "loan[status]", with: "Active"
    select "other category", from: "loan[category_id]"
    click_on("Submit")
    expect(current_path).to eq(loan_path(loan))
    expect(page).to have_content("other test")
    expect(page).to have_content("other test description")
    visit "/categories/#{other_category.id}"
    expect(page).to have_content("other test")
  end

  scenario "can not edit loans with invalid input" do
    log_in_as("admin", "password")
    visit "/admin/loans"
    click_on("Edit")
    fill_in "loan[title]", with: ""
    fill_in "loan[price]", with: "-2"
    click_on("Submit")
    expect(current_path).to eq("/admin/loans/#{loan.id}/edit")
    expect(page).to have_content("Title can't be blank")
    expect(page).to have_content("Price must be greater than 0")
  end
end

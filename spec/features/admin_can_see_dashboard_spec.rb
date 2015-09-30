require "rails_helper"

feature "A visitor logging in" do
  include_context "features"

  scenario "can see the admin dashboard if admin" do
    log_in_as("admin", "password")

    expect(current_path).to eq("/admin/dashboard")
    expect(page).to have_content("Admin Dashboard")
  end

  scenario "can not see the admin dashboard if not an admin" do
    log_in_as("alice", "password")

    expect(current_path).to eq("/dashboard")

    visit "/admin/dashboard"
    expect(page).to have_content("The page you were looking for doesn't exist")
  end

  scenario "can see all orders on dashboard if admin" do
    log_in_as("admin", "password")
    click_button "Ordered"
    expect(page).to have_content("Order ID: #{order.id}")
    expect(page).to have_content("Ordered - 1")
  end

  scenario "can update ordered status to cancelled if admin" do
    log_in_as("admin", "password")
    click_button("Ordered")
    click_link("Cancel")
    click_button("Cancelled")
    within("#Cancelled") do
      expect(page).to have_content(order.id)
      expect(page).to have_content("Cancelled - 1")
    end
  end

  scenario "can update ordered status to paid if admin" do
    log_in_as("admin", "password")
    click_button("Ordered")
    click_link("Mark as Paid")
    click_button("Paid")
    within("#Paid") do
      expect(page).to have_content(order.id)
      expect(page).to have_content("Paid - 1")
    end
  end

  scenario "can update paid order status to cancelled if admin" do
    log_in_as("admin", "password")
    click_button("Paid")
    click_link("Cancel")
    click_button("Cancelled")
    within("#Cancelled") do
      expect(page).to have_content(order.id)
      expect(page).to have_content("Cancelled - 1")
    end
  end

  scenario "can update paid order status to completed if admin" do
    log_in_as("admin", "password")
    click_button("Ordered")
    click_link("Mark as Paid")
    click_button("Paid")
    click_link("Mark as Completed")
    click_button("Completed")
    within("#Completed") do
      expect(page).to have_content(order.id)
      expect(page).to have_content("Completed - 1")
    end
  end
end

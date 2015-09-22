require "rails_helper"

# feature "visitor can view loans by category" do
#   scenario "from the navbar menu" do
#     loan = Loan.create(title: "Kitten Mittens",
#                 description: "Support your kittens!",
#                 price: 50,
#                 avatar: File.open("bird.jpg", "rb"))
#
#     loan2 = Loan.create(title: "Urban Bees",
#                 description: "Local Honey",
#                 price: 50)
#
#     category = Category.create(name: "Crafts")
#     category.loans << loan
#     visit "/loans"
#     find("option[value='#{id}']").click
#     click_button "Go"
#
#     current_path = categories/category_id
#     expect(current_path).to eq(category_path(@category))
#
#
#     within(".header") do
#       expect(page).to have_content("Crafts")
#     end
#     within(".loans") do
#       expect(page).to have_content("Kitten Mittens")
#       expect(page).to have_content("Support your kittens!")
#       expect(page).to have_content("50")
#       expect(page).to have_css("img")
#
#       expect(page).to_not have_content("Urban Bees")
#     end
#   end
# end

feature "visitor can view loans by category" do
  scenario "from the category index" do
    loan = Loan.create(title: "Kitten Mittens",
                description: "Support your kittens!",
                price: 50,
                avatar: File.open("bird.jpg", "rb"))

    loan2 = Loan.create(title: "Urban Bees",
                description: "Local Honey",
                price: 50)

    category = Category.create(name: "Crafts")
    category.loans << loan
    visit "/categories/#{category.id}"
    save_and_open_page
    within(".header") do
      expect(page).to have_content("Crafts")
    end
    within(".loans") do
      expect(page).to have_content("Kitten Mittens")
      expect(page).to have_content("Support your kittens!")
      expect(page).to have_content("50")
      expect(page).to have_css("img")

      expect(page).to_not have_content("Urban Bees")
    end
  end
end

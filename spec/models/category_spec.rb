require 'rails_helper'

RSpec.describe Category, type: :model do
  category = Category.new(name: "crafts")

    it "is valid" do
      expect(category).to be_valid
    end

    it "is invalid without a name" do
      category.name = nil
      expect(category).to_not be_valid
    end
end
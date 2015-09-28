require "rails_helper"

RSpec.describe Loan, type: :model do
  loan = Loan.new(title: "Urban Bees",
                  description: "Buy local Denver honey.",
                  price: 50)

  it "is valid" do
    expect(loan).to be_valid
  end

  it "is invalid without a title" do
    loan.title = nil
    expect(loan).to_not be_valid
  end

  it "is invalid without a description" do
    loan.description = nil
    expect(loan).to_not be_valid
  end

  it "is invalid without a price" do
    loan.price = nil
    expect(loan).to_not be_valid
  end

  it "must have a unique name" do
    old_loan = Loan.new(title: "Test",
                    description: "Buy local Denver honey.",
                    price: 50)
    old_loan.save
    new_loan = Loan.new(title: "Test",
                    description: "Buy local Denver honey.",
                    price: 50)
    expect(old_loan).to be_valid
    expect(new_loan).to_not be_valid
  end
end

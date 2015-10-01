require "rails_helper"

RSpec.describe Order, type: :model do
  include_context "features"
  it "is valid" do
    expect(order).to be_valid
  end

  it "is invalid without a card number" do
    order.card_number = nil
    expect(order).to_not be_valid
  end

  it "is invalid without a card expiration" do
    order.card_expiration = nil
    expect(order).to_not be_valid
  end

  it "is invalid without a status" do
    order.status = nil
    expect(order).to_not be_valid
  end

  it "is invalid with a word non-valid status" do
    order.status = "Good to Go"
    expect(order).to_not be_valid
  end

  it "must belong to a user" do
    order.user_id = nil
    expect(order).to_not be_valid
  end
end

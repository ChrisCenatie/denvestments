require "rails_helper"

describe "Cart Items" do
  it "can't have a negative quantity" do
    cart_item = CartItem.new(1, -5)
    expect(cart_item.quantity).to be >= 0
  end
end

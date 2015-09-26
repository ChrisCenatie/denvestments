require 'rails_helper'

RSpec.describe User, type: :model do
  it "can be created with normal attributes" do
    user = User.create(username: "bob", password: "don't tell nobody")
    expect(User.find_by(username: "bob")).to eq(user)
  end
end

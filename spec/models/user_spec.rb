require "rails_helper"

RSpec.describe User, type: :model do
  before(:each) do
    @user = User.new(username: "bob", password: "secret", full_name: "Bob Doe")
  end

  it "can be created with normal attributes" do
    expect(@user).to be_valid
  end

  it "has a password digest instead of a password" do
    @user.save
    user = User.last
    expect(user.password).to eq(nil)
    expect(user.password_digest).not_to eq("secret")
  end

  it "must have a username" do
    @user = User.new(password: "secret", full_name: "Bob Doe")
    expect(@user).not_to be_valid
  end

  it "must have a password" do
    @user = User.new(username: "bob", full_name: "Bob Doe")
    expect(@user).not_to be_valid
  end

  it "cannot have the same username as another user" do
    @user.save
    new_user = User.new(username: "bob", password: "secret", full_name: "Bob Doe")
    expect(new_user).not_to be_valid
  end

  it "must have a full name" do
    @user = User.new(username: "bob", password: "secret")
    expect(@user).not_to be_valid
  end
end

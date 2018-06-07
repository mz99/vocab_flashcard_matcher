require 'spec_helper'

describe User do
  it "is valid with a name, password and email" do
    user = User.new(
      name: "Jack",
      password: "123",
      email: "tevako@yahoo.com")
    expect(user).to be_valid
  end
  it "is invalid without a name" do
    no_name = User.new(name: nil)
    expect(no_name.valid?).to be_falsey
  end
  it "is invalid without a password" do
    no_password = User.new(password: nil)
    expect(no_password.valid?).to be_falsey
  end
  it "is invalid without an email address" do
    no_email = User.new(email: nil)
    expect(no_email.valid?).to be_falsey
  end
  it "is invalid with a duplicate email address" do
    User.create(
      name: "Jack", password:"123", email: "tevako@yahoo.com")
    user = User.new(
      name: "Jack", password:"435", email: "tevako@yahoo.com")
    expect(user.valid?).to be_falsey
  end
end

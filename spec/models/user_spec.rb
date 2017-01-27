require 'spec_helper'

describe User do
  it "is valid with a name, password and email" do
    user = User.new(
      name: "Mike",
      password: "123",
      email: "ubik00@yahoo.com")
    expect(user).to be_valid
  end
  it "is invalid without a name" do
    expect(User.new(name: nil)).to have(1).errors_on(:name)
  end
  it "is invalid without a password" do
    expect(User.new(password: nil)).to have(1).errors_on(:password)
  end
  it "is invalid without an email address" do
    expect(User.new(email: nil)).to have(1).errors_on(:email)
  end
  it "is invalid with a duplicate email address" do
    User.create(
      name: "Mike", password:"123", email: "ubik00@yahoo.com")
    user = User.new(
      name: "Jack", password:"435", email: "ubik00@yahoo.com")
    expect(user).to have(1).errors_on(:email)
  end
end

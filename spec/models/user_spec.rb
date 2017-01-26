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
  it "is invalid without a password"
  it "is invalid without an email address"
  it "is invalid with a duplicate email address"
end

require 'spec_helper'

feature 'User management'  do
  scenario "adds a new user" do
    visit(root_path)

    click_link('Create your account')
    fill_in('Name', :with => 'mike')
    fill_in('Email', :with => 'stuff@domain.com')
    fill_in('Password', :with => 'k3i0s3l')
    fill_in('Confirmation', :with => 'k3i0s3l')
    submit_form



  end
end

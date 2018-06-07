require 'spec_helper'

feature 'User management', type: :feature do

  scenario "user logs in to their account" do
    sign_in
    expect(page).to have_content("Name: #{@user.name}")
  end

  scenario "create a new account" do
    visit(root_path)
    click_link('Create your account')
    fill_in('Name', :with => 'test 2')
    fill_in('Email', :with => 'test2@test.com')
    fill_in('Password', :with => '123456')
    fill_in('Confirmation', :with => '123456')
    click_on('Create my account')
    expect(page).to have_content("Name: test 2")
    expect(page).to have_content("Welcome to the Vocab Flashcard Matcher!")
  end

  scenario "user edits their profile" do
    sign_in
    click_on('Edit your profile')
    fill_in('Name', with: 'Fred')
    click_on('Update User')
    expect(page).to have_content("Name: Fred")
  end

  scenario "user sees their previous scores" do
    sign_in
    click_on('See your high scores')
    expect(page).to have_content("Your previous scores have been:")
  end

  scenario "user signs out of account" do
    sign_in
    click_on('Sign out of account')
    expect(page).to have_content("All German Vocabulary")
  end

  scenario "user deletes their account" do
    sign_in
    click_on('Delete your profile')
    expect(page).to have_content("All German Vocabulary")
  end
end

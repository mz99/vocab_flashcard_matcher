# Integration test to go through quiz functionality
require 'spec_helper'

feature 'Vocab controller'  do
  scenario "user creates new word successfully" do
    sign_in
    click_on('Go back to index page')
    click_on('Add new word')
    fill_in('Word', with: 'Schlussel')
    fill_in('Definition', with: 'Key')
    click_on('Create Vocab')
    page.has_content?('Word: Schlussel ')
    page.has_content?('Definition: Key ')
  end

  scenario "user edits existing word successfully" do
    sign_in
    click_on('Go back to index page')
    page.find('tr', text: 'Abfahrt').click_link('Edit')
    fill_in('Definition', with: 'Exit')
    click_on('Update Vocab')
    page.has_content?('Definition: Exit')
    save_and_open_page
  end

  scenario "user shows existing word successfully" do
    sign_in
    click_on('Go back to index page')
    page.find('tr', text: 'Abfahrt').click_link('Show')
    page.has_content?('Word: Abfahrt')
  end

  scenario "user deletes word successfully" do
    sign_in
    click_on('Go back to index page')
    page.find('tr', text: 'Abfahrt').click_link('Delete')
    expect(page).not_to have_content('Abfahrt')
  end
end

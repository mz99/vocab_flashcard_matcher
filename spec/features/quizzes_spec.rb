# Integration test to go through quiz functionality
require 'spec_helper'

feature 'Quiz functionality'  do
  scenario "gets 100% questions right in quiz" do
    visit(root_path)
    visit(start_quiz_path)

    27.times do
      orig_value = find('#orig', visible: false).value
      choose(option: orig_value)
      click_on('Submit')
      expect(page).to have_content('You got it right!')
      expect(page).not_to have_content('Sorry, wrong answer!')
    end

    expect(page).to have_content("Your score is 27/27")
    save_and_open_page
  end
end

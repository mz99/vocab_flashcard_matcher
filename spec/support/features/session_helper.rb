module Features
  module SessionHelpers
    def sign_in
      @user = FactoryBot.create(:user)
      visit(root_path)
      click_link('Login')
      fill_in('Email', with: @user.email)
      fill_in('Password', with: @user.password)
      click_on('Log in')
    end
  end
end

class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      flash.now[:danger] = "Your logged in!"
      log_in(user) #refer to helpers/sessions_helper.rb
      redirect_to(user) #user_url(user)
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to(vocabs_path)
  end
end

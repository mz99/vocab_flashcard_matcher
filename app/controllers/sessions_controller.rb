class SessionsController < ApplicationController
  def new
  #generates login page
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      @user = user #question: why do I need to pass user to @user in order for login_in(user) to work even when helper module is trickled down in this controller already?
      log_in @user #log_in(user), refer to helpers/sessions_helper.rb
      current_user #set @current_user variable in helpers/sessions_helper.rb
      redirect_to @user #user_url(user), goto users#show page
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'  #goto sessions#new, routed to localhost:3000/login
    end
  end

  def destroy
    log_out #delete session variable, set @current_user to nil
    redirect_to vocabs_path
  end
end

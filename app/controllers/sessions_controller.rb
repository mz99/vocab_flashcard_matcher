class SessionsController < ApplicationController
  def new #generates login page
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user #log_in(user), refer to helpers/sessios_helper.rb. Assign session variable to user.id
      redirect_to user #user_url(user), goto users#show page
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

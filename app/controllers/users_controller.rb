class UsersController < ApplicationController
  #below is a callback to engage the current_user object
  before_action :require_login, only: [:show, :scores, :edit, :update, :destroy]

  def show
  end

  def scores
    @scores = @current_user.scores
  end

  def new
    @user = User.new
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user
    else
      render 'edit'
    end
  end

  def create
    @user = User.new(user_params)
     if @user.save
       log_in(@user)
       flash[:success] = "Welcome to the Vocab Flashcard Matcher!"
       redirect_to @user
    else
      render 'new'
    end
  end

  def destroy
    @user.destroy
    redirect_to vocabs_path
  end

  private

  def user_params
    params.require(:user).permit(:name,:email, :password,:password_confirmation)
  end


  def require_login
    unless logged_in?
      flash[:error] = "You must be logged in to access this section"
      redirect_to(:controller => 'sessions', :action => 'new')
    end
  end

end

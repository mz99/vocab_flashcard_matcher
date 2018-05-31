class QuizzesController < ApplicationController

  def quiz
    initiate_score
  end

  def answer
    #Keep score and question id's already asked
    if params[:answer] == params[:orig]
      session[:score] += 1
      session[:already_asked] << params[:answer].to_i
      flash[:notice] = "You got it right!"
      redirect_to quiz_path
    else
      session[:already_asked] << params[:orig].to_i
      flash[:notice] = "Sorry, wrong answer!"
      redirect_to quiz_path
    end
  end

  private

  def require_login #can I put this in helper module instead of pasteing it here and in other controller?
    unless logged_in?
      flash[:error] = "You must be logged in to access this section"
      redirect_to sessions_new_path
    end
  end

  def initiate_score
    #Initiate score session
    session[:score] ||= 0
    #Initiate session to hold questions already asked
    session[:already_asked] ||= []
    #Total score
    session[:amount_questions] = Vocab.all.length - 4

    #Get list of words that hasn't been asked before
    @remaining_words = Vocab.all.where.not(id: session[:already_asked])

    #Questions remaining
    @questions_remaining = @remaining_words.length - 4

    #Pick four words from leftover words list
    @question_words = @remaining_words.shuffle.take(4)

    #Create question variable if there are enough words left in list
    if @remaining_words.length >= 4
      @question = @question_words.first.word
    else
      redirect_to result_path
    end

    #save score to user database if all questions done and logged in
    if @questions_remaining == 0
      high_score = Score.new
      high_score.user_id = session[:user_id]
      high_score.score = session[:score] / session[:amount_questions].to_f
      high_score.save
      redirect_to result_path
    end
  end
end

class QuizzesController < ApplicationController

  def quiz
    initiate_score
    remaining_words

    if @questions_remaining == 0  
      save_score_to_db
      redirect_to result_path
    end
  end

  def answer #Keep score and questions already asked
    if params[:answer] == params[:orig]
      right_answer
      redirect_to quiz_path
    else
      wrong_answer
      redirect_to quiz_path
    end
  end

  private

  def initiate_score # Needs to be refactored into multiple methods below
    #Initiate score session
    session[:score] ||= 0
    #Initiate session to hold questions already asked
    session[:already_asked] ||= []
    #Total score
    session[:amount_questions] = Vocab.all.length - 4
  end

  def remaining_words
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
  end

  def save_score_to_db
    high_score = Score.new
    high_score.user_id = session[:user_id]
    high_score.score = session[:score] / session[:amount_questions].to_f
    high_score.save
  end

  def right_answer
    session[:score] += 1
    session[:already_asked] << params[:answer].to_i
    flash[:notice] = "You got it right!"
  end

  def wrong_answer
    session[:already_asked] << params[:orig].to_i
    flash[:notice] = "Sorry, wrong answer!"
  end
end

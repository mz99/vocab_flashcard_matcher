# frozen_string_literal: true

# This controller runs the vocab quiz
class QuizzesController < ApplicationController
  def start_quiz
    clear_session
    redirect_to action: "quiz"
  end

  def quiz
    initiate_quiz
    remaining_words

    if @questions_remaining.zero?
      save_score_to_db
      redirect_to result_path
    end
  end

  def answer
    # Keep track of score and questions already asked
    if params[:answer] == params[:orig]
      right_answer
    else
      wrong_answer
    end
    redirect_to quiz_path
  end

  private

  def initiate_quiz
    session[:score] ||= 0
    session[:vocab_already_asked] ||= []
    session[:number_questions_remaining] = Vocab.all.length - 4
  end

  def remaining_words
    @remaining_words = Vocab.all.where.not(id: session[:vocab_already_asked])
    @questions_remaining = @remaining_words.length - 4
    @quiz_words = @remaining_words.shuffle.take(4)

    if @remaining_words.length >= 4
      @question = @quiz_words.first.word
    else
      redirect_to result_path
    end
  end

  def save_score_to_db
    high_score = Score.new
    high_score.user_id = session[:user_id]
    high_score.score = session[:score] / session[:number_questions_remaining].to_f
    high_score.save
  end

  def right_answer
    session[:score] += 1
    session[:vocab_already_asked] << params[:answer].to_i
    flash[:notice] = 'You got it right!'
  end

  def wrong_answer
    session[:vocab_already_asked] << params[:orig].to_i
    flash[:notice] = 'Sorry, wrong answer!'
  end

  def clear_session
    session[:score] = 0
    session[:vocab_already_asked] = []
  end
end

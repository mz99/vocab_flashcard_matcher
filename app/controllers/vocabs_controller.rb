class VocabsController < ApplicationController
  before_action :require_login, except: [:index, :quiz, :answer, :result]

  def index
    @vocabs = Vocab.all.order("word")
    session[:score] = nil
    session[:already_asked] = nil
  end

  def show
    @vocab = Vocab.find(params[:id])
  end

  def new
    @vocab = Vocab.new
  end

  def edit
    @vocab = Vocab.find(params[:id])
  end

  def create
    @vocab = Vocab.new(vocab_params)
    if @vocab.save
      redirect_to @vocab #redirect to show page for that word since the id is inside
    else
      flash.now[:notice] = "Word or definition can't be blank!"
      render 'new'
    end
  end

  def update
    @vocab = Vocab.find(params[:id])
    if @vocab.update(vocab_params)
      redirect_to @vocab
    else
      render 'edit'
    end
  end

  def destroy
    @vocab = Vocab.find(params[:id])
    @vocab.destroy
    redirect_to vocabs_path
  end

  def quiz

    #Initiate score session
    session[:score] ||= 0
    #Initiate session to hold questions already asked
    session[:already_asked] ||= []
    #Total score
    session[:amount_questions] = Vocab.all.length

    #Get list of words that hasn't been asked before
    @left_words = Vocab.all.where.not(id: session[:already_asked])

    #Questions remaining
    @questions_remaining = @left_words.length - 4

    #Pick four words from leftover words list
    @four = @left_words.shuffle.take(4)

    #Create question variable if there are enough words left in list
    if @left_words.length >= 4
      @question = @four.first.word
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

  def result
  end


  private
    def vocab_params
      params.require(:vocab).permit(:word, :definition)
    end

    def require_login #can I put this in helper module instead of pasteing it here and in other controller?
      unless logged_in?
        flash[:error] = "You must be logged in to access this section"
        redirect_to(:controller => 'sessions', :action => 'new')
      end
    end
end

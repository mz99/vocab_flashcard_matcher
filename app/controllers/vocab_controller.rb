class VocabController < ApplicationController

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
    redirect_to vocab_index_path
  end

  def quiz
    #Initiate score session
    session[:score] ||= 0

    #Initiate session to hold questions already asked
    session[:already_asked] ||= []

    #Get list of words that hasn't been asked before
    @left_words = Vocab.all.where.not(id: session[:already_asked])

    #Pick four words from leftover words list
    @four = @left_words.shuffle.take(4)

    #Create question variable if there are enough words left in list
    if @left_words.length >= 4
      @question = @four.first.word
    else
      redirect_to vocab_index_path
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
      flash[:notice] = "Sorry, wrong answer!"
      redirect_to quiz_path
    end
  end


  private
    def vocab_params
      params.require(:vocab).permit(:word, :definition)
    end
end

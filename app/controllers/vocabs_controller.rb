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

  def create
    @vocab = Vocab.new(vocab_params)
    if @vocab.save
      redirect_to @vocab #redirect to show page for that word since the id is inside
    else
      flash.now[:notice] = "Word or definition can't be blank!"
      render 'new'
    end
  end

  def edit
    @vocab = Vocab.find(params[:id])
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

  private
    def vocab_params
      params.require(:vocab).permit(:word, :definition)
    end

    def require_login #can I put this in helper module instead of pasteing it here and in other controller?
      unless logged_in?
        flash[:error] = "You must be logged in to access this section"
        redirect_to sessions_new_path
      end
    end
end

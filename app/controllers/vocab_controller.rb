class VocabController < ApplicationController

  def index
    @vocabs = Vocab.all.order("word")
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
    @vocabs = Vocab.all
  end

  def search
    if params[:answer] = "1"
      render :text => 'You answered 1'
    else
      render :text => 'You selected something other than 1'
    end
  end

  private
    def vocab_params
      params.require(:vocab).permit(:word, :definition)
    end
end

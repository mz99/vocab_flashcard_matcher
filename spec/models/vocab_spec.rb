require 'spec_helper'

describe Vocab do
  it "is valid with a word and definition" do
    vocab = Vocab.new(
      word: "Achtung",
      definition: "Be careful")
    expect(vocab).to be_valid
  end
  it "is invalid without a word" do
    expect(Vocab.new(word: nil)).to have(1).errors_on(:word)
  end
  it "is invalid without a definition" do
    expect(Vocab.new(definition: nil)).to have(1).errors_on(:definition)
  end

end

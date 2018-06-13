require 'spec_helper'

describe Vocab do
  it "is valid with a word and definition" do
    vocab = Vocab.new(
      word: "Fesnter",
      definition: "Window")
    expect(vocab).to be_valid
  end
  it "is invalid without a word" do
    no_word = Vocab.new(word: nil)
    expect(no_word.valid?).to be_falsey
  end
  it "is invalid without a definition" do
    no_definition = Vocab.new(definition: nil)
    expect(no_definition.valid?).to be_falsey
  end
end

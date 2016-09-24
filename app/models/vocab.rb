class Vocab < ActiveRecord::Base
  validates :word, :definition, presence: true
end

class CreateVocabs < ActiveRecord::Migration
  def change
    create_table :vocabs do |t|
      t.string :word
      t.string :definition

      t.timestamps null: false
    end
  end
end

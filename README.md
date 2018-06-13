# Vocab flashcard matcher
This project was made to make learning German vocabulary fun while getting familiar with the Ruby on Rails framework.




### Installation
Make sure you have ruby version 2.3.1 installed on your system.

Clone the repository:

    git clone https://github.com/mz99/vocab_flashcard_matcher

Install dependencies

cd vocab_flashcard_matcher

    bundle install

Run database migrations

    bin/rake db:create
    bin/rake db:migrate
    bin/rake db:seed

### Test
The tests are created with RSpec, grouped into:
1. Model specs
2. Integration specs

You can run all of the tests with in your Rails-Contracts-API folder:

    bin/rspec

Or selectively:

    bin/rspec spec/models
    bin/rspec spec/features


### Usage
Start the app with:

    bin/rails server



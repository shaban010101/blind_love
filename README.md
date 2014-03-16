# Blind Love

An ecommerce application using Ruby on Rails, which organises products by department and categories . Products can be filtered by pricing and sizing which makes for a convenient shopping experience for customer . The user is able to purchase products using their debit or credit card via stripe payments and also cancel payments if the wish to do so. Rspec and capybara are used to cover unit and integration testing through out the application and VCR is used to stub test API requests.New relic is used to monitor the application. Images are hosted on the Amazon Web Services S3 bucket. 


#### System requirements to use this app:-
Ruby 2.0.0
Rails 3.2.14
Postgres 9.2.4


#### How to install:-
1. Within terminal type in `bundle install` to install the dependencies
2. Setup the Database by typing `rake db:setup`
3. Run the tests using `bundle exec rspec`
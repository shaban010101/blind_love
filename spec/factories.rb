require 'factory_girl'

FactoryGirl.define do
  factory :category do
    category_name "MyString"
  end

  factory :user do
    username "Foo"
    password "Bar"
  end

  factory :product do
  	name "Foo"
  	price 9999
  	description "I am a foobar"
  	category
  end
end


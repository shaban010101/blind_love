require 'factory_girl'

FactoryGirl.define do
  factory :category do
    category_name "Trousers"
    slug "trousers"
    department
    products_attributes { [ FactoryGirl.attributes_for(:product) ]}
  end

  factory :user do
    username "Foo"
    password "Bar"
  end

  factory :product do
  	name "Foo"
  	price 9999
  	description "I am a foobar"
    slug "foo"
  	category
    department
  end

  factory :department do
    department_name "Mens"
    slug "mens"
    products_attributes { [ FactoryGirl.attributes_for(:product) ]}
  end

end


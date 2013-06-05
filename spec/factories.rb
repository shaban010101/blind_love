require 'factory_girl'
require 'spec_helper'

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
    # image fixture_file_upload('/images/boom.jpg', 'image/jpg')
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


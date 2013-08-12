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
  	sequence(:name)  {|n| "Foo#{n}" }
  	price 9999
  	description "I am a foobar"
    slug "foo"
    image Rails.root.join("spec/fixtures/images/boom.jpg").open
  	category
    department
  end

  factory :department do
    department_name "Mens"
    slug "mens"
    products_attributes { [ FactoryGirl.attributes_for(:product) ]}
  end

  factory :size do
    size "Small"
    quantity 1
  end

  factory :sizing do
    size_id 1
    product_id 1
    size
    product
  end

  
  factory :basket do
    basket_id 1
  end

  factory :basket_item do
    product_id 1
    basket_id 1
  end
end


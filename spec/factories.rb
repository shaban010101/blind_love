require 'factory_girl'

FactoryGirl.define do
  factory :category do
    category_name "Trousers"
    slug "trousers"
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
    department "mens"
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
    order
  end

  factory :basket_item do
    product
    basket
    order
  end

  factory :order do
    title "Mr"
    first_name "Foo"
    last_name "Bar"
    address_1 "105 Arcadian Gardens"
    address_2 "London"
  end
end


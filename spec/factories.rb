require 'factory_girl'

FactoryGirl.define do
  factory :category do
    category_name "Trousers"
    slug "trousers"
  end

  factory :user do
    sequence(:email) { |n| "foo#{n}@bar.com" }
    password "BarFarFaz"
    password_confirmation "BarFarFaz"
  end

  factory :department do
    department_name "mens"
    slug "mens"
  end

  factory :product do
  	sequence(:name)  {|n| "Foo#{n}" }
  	price 9999
  	description "I am a foobar"
    slug "foo"
    image Rails.root.join("spec/fixtures/images/boom.jpg").open
    department
    category
  end

  factory :category_department do
    category
    department
  end

  factory :size do
    size_name "Small"
  end

  factory :sizing do
    quantity 10
    size
    product
  end

  factory :basket do
    status "Active"
  end

  factory :basket_item do
    product
    basket
    order
    size
    quantity 1
  end

  factory :order do
   address
   payment
   user
   basket
   total 100
   stripe_id ""
  end

  factory :address do
    sequence(:address_1) {|n| "#{n} Arcadian Gardens" }
    sequence(:address_2) {|n| "Wood Green #{n}"}
    city "London"
    post_code "N15 6PR"
    user
  end

  factory :payment do
    number  4242424242424242
    cvc 234
    year 2020
    month 12
    stripe "cchhcch"
    user
  end
end


require 'factory_girl'

FactoryGirl.define do
  factory :category do
    category_name "Trousers"
    department
    department_id 1

    factory :category_with_products do
      ignore do
        products_count 100
      end

      after(:create) do |category, evaluator|
       FactoryGirl.create_list(:product, evaluator.products_count, category: category )
      end
    end
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
    department
  end

  factory :department do
    department_name "Mens"
  end

end


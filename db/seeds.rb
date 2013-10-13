# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
category= Category.create([{ category_name: 'Accessories'}, {category_name: 'Watches'}, {category_name: 'Underwear'}])
product= Product.create([{:name => 'Foo', :price => 'Bar', :description => 'FooBar', :category_id => 1, :image => File.open("#{Rails.root}/app/assets/images/image1xl6.jpg"),:department => "Mens" }, 
	{:name => "Booz", :price => 222, :description => "Long", :category_id => 2, :image => File.open("#{Rails.root}/app/assets/images/image1xl3.jpg") ,:department => "Mens"},
	{:name => "Steel", :price => 333, :description => "Short", :category_id => 1, :image => File.open("#{Rails.root}/app/assets/images/image1xl.jpg") ,:department => "Mens"},
	{:name => "Bluebird", :price => 233, :description => "Short", :category_id => 2, :image =>  File.open("#{Rails.root}/app/assets/images/image1xl2.jpg") ,:department => "Womens"},
	{:name => "Monza", :price => 633, :description => "Short", :category_id => 1, :image => File.open("#{Rails.root}/app/assets/images/image1xl4.jpg"), :department => "Womens"},
	{:name => "Viva la vida", :price => 353, :description => "Short", :category_id => 2, :image => File.open("#{Rails.root}/app/assets/images/image1xl5.jpg") , :department => "Mens"}
	])
size = Size.create([{:size_name => 'Small'}, {:size_name => "Medium"}, {:size_name => "Large"}, {:size_name => "One Size"}])

user = User.create([{:username => "shaban", :password => "boomting"}])

department = Department.create([:department_name => "mens"], [:department_name => "womens"])
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
department= Department.create([{ department_name: 'Mens' }, { department_name: 'Womens' }, { department_name: 'Kids'}])
category= Category.create([{ category_name: 'Accessories', :department_id => 1}, {category_name: 'Watches', :department_id => 1}, {category_name: 'Underwear'}])
product= Product.create([{:name => 'Foo', :price => 'Bar', :description => 'FooBar', :category_id => 1, :department_id => 1, :image => File.open("#{Rails.root}/app/assets/images/image1xl6.jpg") }, 
	{:name => "Booz", :price => 222, :description => "Long", :category_id => 2, :department_id => 1, :image => File.open("#{Rails.root}/app/assets/images/image1xl3.jpg")},
	{:name => "Steel", :price => 333, :description => "Short", :category_id => 1, :department_id => 1, :image => File.open("#{Rails.root}/app/assets/images/image1xl.jpg")},
	{:name => "Bluebird", :price => 233, :description => "Short", :category_id => 2, :department_id => 1, :image =>  File.open("#{Rails.root}/app/assets/images/image1xl2.jpg")},
	{:name => "Monza", :price => 633, :description => "Short", :category_id => 1, :department_id => 1, :image => File.open("#{Rails.root}/app/assets/images/image1xl4.jpg")},
	{:name => "Viva la vida", :price => 353, :description => "Short", :category_id => 2, :department_id => 1, :image => File.open("#{Rails.root}/app/assets/images/image1xl5.jpg")}
	])
size = Size.create([{:size => 'Small'}, {:size => "Medium"}, {:size => "Large"}, {:size => "One Size"}])

user = User.create([{:username => "shaban", :password => "boomting"}])